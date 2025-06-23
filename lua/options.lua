-- init.lua
--––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
-- neovim-in-VSCode options (only)
-- https://neovim.io/doc/user/options.html

-- leader key
vim.g.mapleader = " "

-- tabs & indents
vim.o.tabstop       = 4
vim.o.softtabstop   = 4
vim.o.shiftwidth    = 4
vim.o.expandtab     = true
vim.o.smartindent   = true
vim.o.autoindent    = true

-- line numbers
vim.o.nu             = true
vim.o.relativenumber = true
vim.o.scrolloff      = 8
vim.o.signcolumn     = 'yes'

-- display
vim.o.wrap           = false
vim.o.colorcolumn    = "81"       -- column guide at 81
vim.o.textwidth      = 80
vim.o.termguicolors  = true

-- searching
vim.o.incsearch      = true
vim.o.ignorecase     = true
vim.o.smartcase      = true

-- undo & swap
vim.o.swapfile       = false
vim.o.backup         = false
vim.o.undodir        = vim.env.HOME .. "/.vimfiles/undodir"
vim.o.undofile       = true

-- folds & mouse
vim.o.foldmethod = "manual" -- manual, syntax, indent etc, see :help fold.txt
---- causes problems when system clipboard doesn't support some special
---- characters, best to keep vim clipboard and system clipboard separate
vim.o.mouse          = "nv" -- use "" to turn off

-- keep the sign-column always visible
vim.o.signcolumn     = "yes"

-- special options
vim.o.hidden = false    -- When off a buffer is unloaded (including loss of undo information) when it is |abandon|ed.  When on a buffer becomes hidden when it is |abandon|ed.  A buffer displayed in another window does not become
vim.o.autochdir = false -- When on, Vim will change the current working directory whenever you open a file, switch buffers, delete a buffer or open/close a window.

-- handle + register via clipboard
vim.opt.clipboard:append("unnamedplus")

-- WSL interop clipboard (if on WSL)
local wsl_interop = os.getenv("WSL_INTEROP")
if wsl_interop and wsl_interop:find("WSL") then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy =  { ['+'] = 'clip.exe', ['*'] = 'clip.exe' },
    paste = { ['+'] = 'powershell.exe -NoProfile -c Get-Clipboard -Raw',
              ['*'] = 'powershell.exe -NoProfile -c Get-Clipboard -Raw' },
    cache_enabled = 0,
  }
end

-- disable diagnostic underlines only in VSCode (neovim) mode
if vim.g.vscode then
    -- configure LSP diagnostics: no underlines in embedded VS Code Neovim
    vim.diagnostic.config({
        underline = false,       -- turn off squiggly underlines
        signs = true,            -- keep gutter signs
        virtual_text = true,     -- keep inline virtual text
        update_in_insert = false -- no updates while typing
    })
else
    -- ordinary Neovim (non-VS Code) mode
    -- e.g., vim.o.spell = true
end
  