# nvim
My Neovim configurations, made for cross system/OS portability

## Installation 
1. Install Packer via provided script or at https://github.com/wbthomason/packer.nvim
2. Open `lua/plugins.lua` with `nvim`
3. Souce the file with `:source` or `:so`
4. Run `:PackerSync` within Neovim

## Copilot
Follow instructions here https://github.com/github/copilot.vim

#### TL;DR
1. Install Node.js - for Debian

        curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
        sudo apt install -y nodejs


2. clone the copilot repo - for Debian 

        git clone https://github.com/github/copilot.vim.git \
        ~/.config/nvim/pack/github/start/copilot.vim
3. Run `:Copilot setup` within Neovim

