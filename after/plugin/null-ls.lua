local null_ls = require("null-ls")

null_ls.setup({
    -- debug = true,
    sources = {
        -- Python Formatting
        null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length", "88" }, -- Optional: Customize line length
        }),
        null_ls.builtins.formatting.isort,          -- Sort imports in Python

        -- Python Linting
        -- null_ls.builtins.diagnostics.flake8, -- Linter for Python

        -- C++ Formatting
        -- null_ls.builtins.formatting.clang_format.with({
        --     extra_args = {
        --         "--fallback-style={BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 100, AlignAfterOpenBracket: Align, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, ReflowComments: false}"
        --     },
        -- }),

        -- C++ Linting
        -- null_ls.builtins.diagnostics.cpplint,
    },

    -- Auto-format on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
