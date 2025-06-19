" init.vim básico para Neovim (uso con Stow)

" Usa vim-plug para gestionar plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
call plug#end()

set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set clipboard=unnamedplus
set undofile
set undodir=~/.config/nvim/undodir
syntax enable
filetype plugin indent on

" Atajos útiles
nnoremap <C-n> :NvimTreeToggle<CR>
let mapleader = " "

" Lualine (barra de estado moderna)
require('lualine').setup {}

" LSP básico para Python y bash (puedes añadir más)
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.bashls.setup{}

" Telescope (buscador rápido)
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>

" Comentarios:
" - Instala vim-plug si no lo tienes: https://github.com/junegunn/vim-plug
" - Instala los servidores LSP recomendados con :LspInstall
" - Personaliza los plugins y atajos según tus necesidades
