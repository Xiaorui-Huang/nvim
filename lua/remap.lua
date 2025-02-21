if not vim.g.vscode then
    -- file explorer
    -- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- overrided by nvim-tree

    -- search remaps
    -- https://vim.fandom.com/wiki/Search_for_visually_selected_text
    vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

    -- system clipboard remap
    -- vim.keymap.set("n", "<leader>y", "\"+y")
    -- vim.keymap.set("v", "<leader>y", "\"+y")
    -- vim.keymap.set("n", "<leader>Y", "\"+Y")

    -- Window resizing
    vim.keymap.set("n", "<M-[>", ":resize -2<CR>")
    vim.keymap.set("n", "<M-]>", ":resize +2<CR>")
    vim.keymap.set("n", "<M-{>", ":vert :resize -2<CR>")
    vim.keymap.set("n", "<M-}>", ":vert :resize +2<CR>")

    -- Window Navigation
    vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
    vim.keymap.set("n", "<leader>j", ":wincmd j<CR>")
    vim.keymap.set("n", "<leader>k", ":wincmd k<CR>")
    vim.keymap.set("n", "<leader>l", ":wincmd l<CR>")

    -- Buffer Navigation
    vim.keymap.set("n", "<leader>w", ":bn<CR>")
    vim.keymap.set("n", "<leader>b", ":bp<CR>")
    vim.keymap.set("n", "<leader>d", ":bd<CR>")

    -- Source the current file
    vim.keymap.set("n", "<C-s>", ":w<CR> :so<CR>", { silent = true })

    -- Copilot keybindings
    vim.keymap.set("n", "<leader>cp", vim.cmd.Copilot)

    -- Move lines or blocks with Alt-j/k
    vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
    vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
    vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")
    vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi")
    vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi")

    -- Modifications
    vim.keymap.set("n", "J", "mzJ`z")         -- let the cursor stay in place with mark at z
    vim.keymap.set("n", "<C-d>", "<C-d>zz")   -- center cursor after move
    vim.keymap.set("n", "<C-u>", "<C-u>zz")   -- center cursor after move
    vim.keymap.set("x", "<leader>p", "\"_dP") -- preserve original when pasting over
end
