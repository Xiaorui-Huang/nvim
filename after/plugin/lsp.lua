-- clangd setup block removed

-- Setup LSP capabilities with blink.cmp integration
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- Add borders to floating windows
vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
    return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend('keep', config or {}, { border = 'rounded' }))
end
vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
    return vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_extend('keep', config or {}, { border = 'rounded' }))
end

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

-- Configure language servers using vim.lsp.config (Neovim 0.11+)
if vim.fn.has('nvim-0.11') == 1 then
    -- Python
    vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        root_markers = { 'pyproject.toml', 'setup.py' },
        capabilities = capabilities,
    })
    vim.lsp.enable('pyright')

    -- Lua
    vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        root_markers = { '.luarc.json', '.luarc.jsonc', 'selene.toml', 'stylua.toml' },
        capabilities = capabilities,
    })
    vim.lsp.enable('lua_ls')

    -- Gleam
    vim.lsp.config('gleam', {
        cmd = { 'gleam', 'lsp' },
        root_markers = { 'gleam.toml' },
        capabilities = capabilities,
    })
    vim.lsp.enable('gleam')
else
    -- Fallback for older Neovim versions using lsp-zero
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
    end)

    lsp.ensure_installed({
        'pyright',
    })

    require('lspconfig').lua_ls.setup({})
    require('lspconfig').gleam.setup({})
    lsp.nvim_workspace()
    lsp.setup()
end

-- Format on save
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
            return
        end

        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end
})

-- Completion is handled by blink.cmp (configured in plugins.lua)
