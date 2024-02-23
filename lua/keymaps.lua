-- keymaps
local keymap = vim.keymap -- for conciseness

keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw explorer" })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })

-- Center cursor on screen when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down, and center cursor" }) 
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up, and center cursor" }) 

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffers
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- LSP stuff
keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- TODO: Ideally set these up on LspAttach
--https://github.com/neovim/nvim-lspconfig
keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show symbol info" })
