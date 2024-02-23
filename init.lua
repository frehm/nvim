require("options")
require("keymaps")

if vim.g.neovide then
   vim.o.guifont = "Cascadia Mono:h12" 
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("mason").setup()
require("mason-lspconfig").setup()
require('lualine').setup()

-- add setup of lsp servers via lspconfig
require("lspconfig").pyright.setup {}

vim.cmd[[colorscheme tokyonight]]
