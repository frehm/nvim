local function augroup(name)
  return vim.api.nvim_create_augroup("frehm_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- register axaml files as xml
vim.filetype.add({
	extension = {
		axaml = "xml",
	},
})

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- start treesitter, install parser if not already installed
vim.api.nvim_create_autocmd({ 'Filetype' }, {
  group = augroup("treesitter"),
  callback = function(event)
    local ft = vim.bo[event.buf].ft

    -- dont't try to start treesitter for snacks plugins
    if string.starts(ft, "snacks_") then return end
        
    -- make sure nvim-treesitter is loaded
    local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

    -- no nvim-treesitter, maybe fresh install
    if not ok or not nvim_treesitter.install then return end

    -- get language for filetype, since they aren't always the same
    local lang = vim.treesitter.language.get_lang(ft)

    -- check if parser is available for language
    local parsers = require('nvim-treesitter.parsers')
    if not lang or not parsers[lang] then
        vim.notify('Parser not available for ft/lang: ' .. ft .. '/' .. lang)
        return
    end
     
    -- install, if not already installed, then start treesitter
    vim.notify('Starting treesitter for ft/lang: ' .. ft .. '/' .. lang)

    nvim_treesitter.install({ lang }):await(function(err)
      if err then
        vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
        return
      end

      pcall(vim.treesitter.start, event.buf)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end)
  end,
})
