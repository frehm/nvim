local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

opt.autowrite = false
opt.relativenumber = true
opt.number = true

-- if true, show confirm message instead of error
opt.confirm = false

opt.cursorline = true -- Enable highlighting of the current line
opt.mouse = ""

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true -- Round indent

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically (what's the difference with autoindent?)
opt.termguicolors = true -- True color support
opt.timeoutlen = 300

opt.scrolloff = 8
opt.sidescrolloff = 8 -- Columns of context
opt.smoothscroll = true

opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

opt.linebreak = true -- Wrap lines at convenient points
opt.wrap = false

opt.shadafile = "NONE" -- Disable shada file (no persistent history)
opt.swapfile = false -- Disable swapfile (use git etc. for recovery)

-- show diagnostics inline if true
-- TODO: Add a toggle for this
vim.diagnostic.config({
  virtual_text = true,
})

-- vim.opt.foldtext = ""
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1
-- vim.opt.foldnestmax = 4
