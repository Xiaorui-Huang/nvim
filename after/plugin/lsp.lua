-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

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
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)


-- format on save
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
            return
        end

        if client.supports_method('textDocument/formatting') then
            lsp.buffer_autoformat()
        end
    end
})

-- Replace the language servers listed here
-- with the ones you have installed in your system
require('lspconfig').gleam.setup({})
require('lspconfig').lua_ls.setup({})




lsp.ensure_installed({
    -- "rust_analyzer",
    "pyright",

    ---- installed manually
    -- "clangd",
    -- "lua_ls",
})

-- don't initialize this language server
lsp.skip_server_setup({
    -- we will use rust-tools to setup rust_analyzer
    -- 'rust_analyzer',
    "clangd",
})


require('lspconfig').clangd.setup({
    cmd = {
        'clangd',
        '--fallback-style=WebKit'
    },
})

require('lspconfig').lua_ls.setup({})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
    },
    -- preselect = 'item',
    -- completion = {
    --     completeopt = 'menu,menuone,noinsert',
    --     -- autocomplete = false,  -- for manual completion
    -- },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            -- vim.snippet.expand(args.body)
            require('luasnip').lsp_expand(args.body)
        end,
    },


    mapping = cmp.mapping.preset.insert({
        -- Super tab
        ['<Tab>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            local col = vim.fn.col('.') - 1

            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item({ behavior = 'select' })
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        -- Super shift tab
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')

            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item({ behavior = 'select' })
            else
                fallback()
            end
        end, { 'i', 's' }),

        -- -- Simple tab complete
        -- ['<Tab>'] = cmp.mapping(function(fallback)
        --     local col = vim.fn.col('.') - 1

        --     if cmp.visible() then
        --         cmp.select_next_item({ behavior = 'select' })
        --     elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        --         fallback()
        --     else
        --         cmp.complete()
        --     end
        -- end, { 'i', 's' }),

        -- -- Go to previous item
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- ['<C-Space>'] = cmp.mapping.complete(), -- for manual completion
    }),
})

-- require('rust-tools').setup({
--     server = lsp.build_options('rust_analyzer', { single_file_support = false, }),
-- })

-- https://www.jvt.me/posts/2022/03/01/neovim-format-on-save/
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })]]
