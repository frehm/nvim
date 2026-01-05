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

    -- which-key
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts_extend = { "spec" },
        opts = {
            preset = "modern",
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

