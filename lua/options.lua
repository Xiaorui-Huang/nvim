-- neovim options
-- https://neovim.io/doc/user/options.html
vim.g.mapleader = " "

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.autoindent = true

vim.o.nu = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.signcolumn = 'yes'

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.env.HOME .. "/.vimfiles/undodir"
vim.o.undofile = true

vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.textwidth = 80
vim.o.colorcolumn = "81"
---- fold settings
-- vim.o.foldmethod = "manual"
---- causes problems when system clipboard doesn't support some special
---- characters, best to keep vim clipboard and system clipboard separate
-- vim.opt.clipboard:append('unnamedplus')
-- vim.o.mouse = "a"

-- special options
vim.o.hidden = false    -- When off a buffer is unloaded (including loss of undo information) when it is |abandon|ed.  When on a buffer becomes hidden when it is |abandon|ed.  A buffer displayed in another window does not become
vim.o.autochdir = false -- When on, Vim will change the current working directory whenever you open a file, switch buffers, delete a buffer or open/close a window.

-- if vim.g.vscode then
--     -- VSCode extension
-- else
--     -- ordinary Neovim
-- end

vim.o.spell = true
vim.opt.clipboard:append("unnamedplus")

local wsl_interop = os.getenv("WSL_INTEROP")
if wsl_interop and wsl_interop:find("WSL") then
    vim.g.clipboard = {
      name = "WslClipboard",
      copy = {
        ['+'] = 'clip.exe',
        ['*'] = 'clip.exe',
      },
      paste = {
        ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Cli',
        ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Cli',
      },
      cache_enabled = 0,
    }
end
