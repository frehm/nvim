local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically (what's the difference with autoindent?)
opt.termguicolors = true -- True color support
opt.scrolloff = 8
