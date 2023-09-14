<div align="center">

# asdf-llvm [![Build](https://github.com/higebu/asdf-llvm/actions/workflows/build.yml/badge.svg)](https://github.com/higebu/asdf-llvm/actions/workflows/build.yml) [![Lint](https://github.com/higebu/asdf-llvm/actions/workflows/lint.yml/badge.svg)](https://github.com/higebu/asdf-llvm/actions/workflows/lint.yml)

[llvm](https://llvm.org/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- [Ninja](https://ninja-build.org/): for build clang.

# Install

Plugin:

```shell
asdf plugin add clang https://github.com/higebu/asdf-llvm.git
asdf plugin add clang-format https://github.com/higebu/asdf-llvm.git
asdf plugin add clangd https://github.com/higebu/asdf-llvm.git
asdf plugin add llvm-objcopy https://github.com/higebu/asdf-llvm.git
asdf plugin add llvm-objdump https://github.com/higebu/asdf-llvm.git
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/higebu/asdf-llvm/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Yuya Kusakabe](https://github.com/higebu/)
