# nvim

Minimal Neovim configuration.

## Prerequisites

- Neovim >= 0.11.0
- Git
- Nerd Font
- C compiler (e.g. gcc, clang)


### Treesitter

`nvim-treesitter` requires `tree-sitter-cli` to be installed for compiling parsers. And to install it using `cargo` a C compiler is needed. On Windows, install Visual Studio Build Tools with C++ workload (or Visual Studio Community/Professional).

Install `tree-sitter-cli` with: `cargo install --locked tree-sitter-cli`.

Docs

* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)


## LSP Setup

### Python (basedpyright)

Install globally with: `uv tool install basedpyright`. Check [uv](https://docs.astral.sh/uv/) for installation docs if missing `uv`. Docs for `basedpyright` can be found [here](https://docs.basedpyright.com/latest/).

### C# (csharp-language-server)

Install globally with: `cargo install csharp-language-server`. Run `csharp-language-server --download` to download the actual language server. It will be downloaded automatically on first run, but the command can be run manually to avoid delays.

Docs at [csharp-language-server](https://github.com/SofusA/csharp-language-server).
