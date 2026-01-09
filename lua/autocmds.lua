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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cs',
  callback = function(args)
    vim.notify("Starting LSP...")

    local root_dir = vim.fs.root(args.buf, function(name, path)
        return name:match('%.csproj$') ~= nil
    end)

    vim.lsp.start({
      name = 'csharp-language-server',
      cmd = {'csharp-language-server'},
      root_dir = root_dir,
    })
  end,
})

-- add keymaps when attaching lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup("lsp"),
  callback = function(event)
    local bufmap = function(mode, rhs, lhs, desc)
      vim.keymap.set(mode, rhs, lhs, {buffer = event.buf, desc = desc})
    end

    vim.notify("LSP attached, adding keymaps...")

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', 'LSP Hover Documentation')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'LSP References')
    bufmap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation')
    bufmap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'LSP Rename Symbol')
    bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'LSP Code Action')
    bufmap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', 'LSP Document Symbols')
    bufmap({'i', 's'}, 'gK', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'LSP Signature Help')

    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Goto Definition')
    bufmap('n', 'gY', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Goto T[y]pe Definition')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto Declaration')
    bufmap({'n', 'x'}, '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format')

    -- doesn't work?
    bufmap('n', '<leader>ud', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>', 'Toggle Inlay Hints')

    -- bufmap('i', '<C-space>', '<cmd>lua vim.lsp.completion.trigger()<cr>', 'LSP Completion Trigger')

  end,
})

-- vim.opt.completeopt = {'menu', 'menuone', 'noinsert', 'noselect'}
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--   desc = 'Enable vim.lsp.completion',
--   callback = function(event)
--     local client_id = vim.tbl_get(event, 'data', 'client_id')
--     if client_id == nil then
--       return
--     end
--
--     vim.notify("Enabling LSP completion...")
--
--     vim.lsp.completion.enable(true, client_id, event.buf, {autotrigger = true})
--
--   end
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--   desc = 'Enable inlay hints',
--   callback = function(event)
--     local id = vim.tbl_get(event, 'data', 'client_id')
--     local client = id and vim.lsp.get_client_by_id(id)
--     if client == nil or not client.supports_method('textDocument/inlayHint') then
--       return
--     end
--
--     vim.notify("Enabling LSP inlay hints...")
--     vim.lsp.inlay_hint.enable(true, {bufnr = event.buf})
--   end,
-- })
