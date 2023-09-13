<div align="center">

# asdf-clang [![Build](https://github.com/higebu/asdf-clang/actions/workflows/build.yml/badge.svg)](https://github.com/higebu/asdf-clang/actions/workflows/build.yml) [![Lint](https://github.com/higebu/asdf-clang/actions/workflows/lint.yml/badge.svg)](https://github.com/higebu/asdf-clang/actions/workflows/lint.yml)

[clang](https://github.com/higebu/asdf-clang) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add clang
# or
asdf plugin add clang https://github.com/higebu/asdf-clang.git
```

clang:

```shell
# Show all installable versions
asdf list-all clang

# Install specific version
asdf install clang latest

# Set a version globally (on your ~/.tool-versions file)
asdf global clang latest

# Now clang commands are available
clang --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/higebu/asdf-clang/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Yuya Kusakabe](https://github.com/higebu/)
