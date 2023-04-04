" init.vim for Windows 

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set autochdir

set nu
set relativenumber
set scrolloff=8
set signcolumn=yes

set hidden
set nowrap
set noswapfile
set undodir=~\.vimfiles\undodir
set undofile

set ignorecase
set smartcase
set incsearch
set textwidth=80
set colorcolumn=81
set foldmethod=manual
set clipboard=unnamedplus
set spell
set mouse=a

" Plugins 
"=============== vim-plug Plugin Manager ===============
call plug#begin(stdpath('data') . '/plugged')
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plug 'preservim/nerdcommenter'
" Plug 'gruvbox-community/gruvbox', Cond(!exists('g:vscode'))
Plug 'vim-airline/vim-airline', Cond(!exists('g:vscode'))
Plug 'neovim/nvim-lspconfig', Cond(!exists('g:vscode'))
Plug 'nvim-lua/completion-nvim', Cond(!exists('g:vscode'))
Plug 'sakshamgupta05/vim-todo-highlight', Cond(!exists('g:vscode'))
" ultinips is the engine for the snippets
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' 

"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jiangmiao/auto-pairs'
" Basically for that sweet Snippets command
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'


call plug#end()

" BRIEF HELP
" PlugInstall [name ...] [#threads]	Install plugins
" PlugUpdate [name ...] [#threads]	Install or update plugins
" PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
" PlugUpgrade	Upgrade vim-plug itself
" PlugStatus		Check the status of plugins
" PlugDiff		Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins
"=======================================================

" Themes
set termguicolors 
let g:gruvbox_italic=1
if !exists('g:vscode')
    colorscheme gruvbox
endif
highlight Normal ctermbg=none guibg=none
highlight NoneText ctermbg=none guibg=none
highlight ColorColumn ctermbg=15
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

"LSP setup 
set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
lua << EOF
-- local on_attach = require'completion'.on_attach
-- require'lspconfig'.clangd.setup{on_attach=on_attach}
-- require'lspconfig'.pyright.setup{on_attach=on_attach}
-- require'lspconfig'.intelephense.setup{on_attach=on_attach}

-- Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require'lspconfig'.html.setup {
--   capabilities = capabilities;
--   on_attach=require'completion'.on_attach
-- }
EOF

" Remaps and lets
let mapleader = " "
let g:NERDAltDelims_c = 1
"let g:UltiSnipsExpandTrigger='<leader><tab>'
"let g:completion_enable_snippet = 'UltiSnips'
"let g:completion_enable_auto_paren = 1
let g:netrw_winsize=75
      
" Add a new line in noraml mode
nnoremap <CR> o<Esc>
":%s/\n\s*{/{/

" Move lines or blocks with alt
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

"Temporary map to source init.vim
nnoremap <silent> <C-s> :w<CR> :so %<CR>

"LSP remaps
""nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
""nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
""nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
""nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
"dont know what these do
""nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR> 
""nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
""nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
""nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
""nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
"vim.lsp.buf.formatting()

" Vim window navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Buffer navigations
nnoremap <Leader>w :bn<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>d :bd<CR>

" Fold
""augroup AutoSaveFolds
  ""autocmd!
  ""autocmd BufWinLeave * silent! mkview
  ""autocmd BufWinEnter * silent! loadview
""augroup END

" WSL clipboard
" WSL yank support to windows clipboard
" change this path according to your mount point
"let s:clip = '/mnt/c/Windows/System32/clip.exe'  
"if executable(s:clip)
    "augroup WSLYank
        "autocmd!
        "autocmd TextYankPost * if v:event.operator ==# 'y' | 
                    "\ call system('cat |' . s:clip, @0) | endif 
    "augroup END
"endif

" map "+p to get the windows clipboard into WSL vim
"map <silent> "+p :r !powershell.exe -Command Get-Clipboard<CR>


