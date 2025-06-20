# nvim
My Neovim configurations, made for cross machine/OS portability

## Installation
1. Clone this repo at

    * Linus/macOS
        
          git clone git@github.com:Xiaorui-Huang/nvim.git ~/.config/nvim
        
    * Windows
        
          git clone git@github.com:Xiaorui-Huang/nvim.git $HOME/AppData/Local/nvim
        
2. Launch `nvim` once. It will automatically install [lazy.nvim](https://github.com/folke/lazy.nvim).
3. Run `:Lazy sync` within Neovim to install plugins.
   You can also run `lazy_unix.sh` (or `lazy_windows.ps1` on Windows) to install the manager manually.

Note: plugin `nvim-treesitter` requires at least the latest stable [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Copilot
Follow instructions here https://github.com/github/copilot.vim

#### TL;DR
1. Install Node.js 16.x or above - for Debian

        brew install node

2. clone the copilot repo - for Debian 

        git clone https://github.com/github/copilot.vim.git \
        ~/.config/nvim/pack/github/start/copilot.vim
3. Run `:Copilot setup` within Neovim

