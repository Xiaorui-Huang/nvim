# nvim
My Neovim configurations, made for cross machine/OS portability

## Installation
1. Clone this repo at

    * Linus/macOS
        
          ~/.config/nvim/pack/github/start/copilot.vim
        
    * Windows
        
          $HOME/AppData/Local/nvim/pack/github/start/copilot.vim
        
2. Install Packer via provided script or at https://github.com/wbthomason/packer.nvim
3. Open `lua/plugins.lua` with `nvim`
4. Souce the file with `:source` or `:so`
5. Run `:PackerSync` within Neovim

Note: plugin `nvim-treesitter` requires at least the latest stable [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Copilot
Follow instructions here https://github.com/github/copilot.vim

#### TL;DR
1. Install Node.js 16.x or above - for Debian

        curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
        sudo apt install -y nodejs


2. clone the copilot repo - for Debian 

        git clone https://github.com/github/copilot.vim.git \
        ~/.config/nvim/pack/github/start/copilot.vim
3. Run `:Copilot setup` within Neovim

