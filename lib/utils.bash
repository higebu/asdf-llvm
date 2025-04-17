#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/llvm/llvm-project"
__dirname="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOL_NAME="$(basename "$(dirname "${__dirname}")")"
TOOL_TEST="$TOOL_NAME --version"

fail() {
	echo -e "asdf-llvm: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^llvmorg-//'
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/archive/llvmorg-${version}.tar.gz"

	echo "* Downloading LLVM release $version for $TOOL_NAME..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"
	local bin_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-llvm supports release installs only"
	fi

	# Build from source
	(
		mkdir -p "$bin_path"
		cd "$ASDF_DOWNLOAD_PATH"
		cmake -S llvm -B build -G Ninja \
			-DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra' \
			-DLLVM_BUILD_RUNTIME="OFF" \
			-DBUILD_SHARED_LIBS="OFF" \
			-DCMAKE_INSTALL_PREFIX="/usr/local" \
			-DCMAKE_BUILD_TYPE=Release
		ninja -C build $TOOL_NAME
		strip build/bin/$TOOL_NAME
		cp build/bin/$TOOL_NAME "$bin_path"
		if [ "$TOOL_NAME" = "clang" ]; then
			# Create symlinks to clang++ and other tools produced by clang
			ln -sf "$TOOL_NAME" "$bin_path/clang++"
			ln -sf "$TOOL_NAME" "$bin_path/clang-cl"
			ln -sf "$TOOL_NAME" "$bin_path/clang-cpp"

			cp -r build/lib "$install_path"
		fi
		cd ..
		rm -rf "$ASDF_DOWNLOAD_PATH"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$bin_path/$tool_cmd" || fail "Expected $bin_path/$tool_cmd to be executable."
		if [ "$TOOL_NAME" = "clang" ]; then
			test -x "$bin_path/clang++" || fail "Expected $bin_path/clang++ to be executable."
			test -x "$bin_path/clang-cl" || fail "Expected $bin_path/clang-cl to be executable."
			test -x "$bin_path/clang-cpp" || fail "Expected $bin_path/clang-cpp to be executable."
		fi

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$bin_path"
		rm -rf "$ASDF_DOWNLOAD_PATH"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
