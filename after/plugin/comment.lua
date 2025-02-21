require('Comment').setup({
    ignore = '^$',
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        line = '<leader>cc',
        block = '<leader>bc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        line = '<leader>c',
        block = '<leader>bl',
    },
    extra = {
        ---Add comment on the line above
        above = '<leader>cO',
        ---Add comment on the line below
        below = '<leader>co',
        ---Add comment at the end of line
        eol = '<leader>cA',
    },
})
