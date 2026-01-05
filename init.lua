require("options")
require("keymaps")
require("autocmds")

vim.g.have_nerd_font = true

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

require("lazy").setup({
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        priority = 1000, -- make sure to load first
        opts = { style = "moon" },
        config = function(_, opts)
            require("tokyonight").setup(opts)

            vim.cmd.colorscheme('tokyonight')
        end
    },

    -- mini.icons
    { 'nvim-mini/mini.icons', 
        version = '*' ,
       config = true, -- not needed to load since lazy is not true?
    },

    -- snacks.nvim
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            explorer = { enabled = true },
            indent = { enabled = true },
            picker = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            -- show file as quickly as possible when nvim some_file.ext
            quickfile = { enabled = true },
            -- smooth scrolling animation
            scroll = { enabled = true },
            -- TODO: enable scope after adding tree-sitter
            -- scope = { enabled = true },
        },
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            -- other
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        }
    },
    -- which-key
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts_extend = { "spec" },
        opts = {
            preset = "helix",
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.o.timeoutlen
            delay = 0,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
            },

            -- Document existing key chains
            spec = {
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
            },
            keys = {
            {
                "<leader>?",
                function()
                require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
        },
    }, -- which-key

})

