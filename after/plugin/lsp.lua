-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    vim.keymap.set("n", "H", "K", { buffer = true })
end)

lsp.ensure_installed({
    "rust_analyzer",
})

-- don't initialize this language server
-- we will use rust-tools to setup rust_analyzer
lsp.skip_server_setup({ 'rust_analyzer' })

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

require('rust-tools').setup({
    server = lsp.build_options('rust_analyzer', { single_file_support = false, }),
})

-- https://www.jvt.me/posts/2022/03/01/neovim-format-on-save/
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })]]
