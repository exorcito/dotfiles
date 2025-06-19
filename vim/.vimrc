set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8

" Detectar si se está usando Neovim
if has('nvim')
  " Plugins esenciales para Neovim con vim-plug
  if filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
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
  endif
  set clipboard=unnamedplus
  set number
  set relativenumber
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set smarttab
  set undofile
  set undodir=~/.config/nvim/undodir
  syntax enable
  filetype plugin indent on
else
  " Vim clásico: solo plugins y opciones esenciales
  if filereadable(expand('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    call plug#end()
  else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'vim-airline/vim-airline'
    call vundle#end()
  endif
  set clipboard=unnamed
  set number
  set relativenumber
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set smarttab
  set undofile
  set undodir=~/.vim/undodir
  syntax enable
  filetype plugin indent on
endif

" Atajos útiles y multiplataforma
noremap n nzz
noremap N Nzz
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
let mapleader= " "

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Airline
let g:airline_powerline_fonts = 1

" Clipboard multiplataforma
if has('nvim') || has('unix')
  let s:uname = system('uname')
  if s:uname =~? 'Darwin'
    set clipboard=unnamed
  else
    set clipboard=unnamedplus
  endif
endif

" Color scheme & syntax configuration
colorscheme molokai
set t_Co=256
syntax enable
filetype plugin on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=2
set smarttab
set expandtab
set swapfile
set dir=/tmp
set nojoinspaces
set number
set relativenumber
set undofile
set undodir=~/.vim/undodir

let g:deoplete#enable_at_startup = 1

" Show next matched string at the center of the screen
noremap n nzz
noremap N Nzz

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" move between splits on single key
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" multiple cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_exit_from_visual_mode=1
let g:multi_cursor_exit_from_insert_mode=1
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-l>'
let g:multi_cursor_quit_key='<Esc>'

" nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" go-vim
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_disable_autoinstall = 0
let g:go_fmt_command = "goimports"
let g:go_metalinter_command='golangci-lint'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

au FileType go nmap <leader>t :GoTest! -race<cr>
au FileType go nmap <leader>r :GoCoverageToggle -race<cr>
au FileType go nmap <leader>e :GoMetaLinter<cr>

" save from leader
nnoremap <leader>w <esc>:w<cr><space>
nnoremap <leader>wq <esc>:wqa<cr><space>

" vim fugitive"
nmap <leader>y :Gstatus<cr>
nmap <leader>u :Gcommit<cr>

" vim-jsx
let g:jsx_ext_required = 0

" vim-javascript
let g:javascript_enable_domhtmlcss = 1
let g:javascript_plugin_jsdoc = 1

" Cursor relative number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set relativenumber

" fzf configuration
if !empty(glob("/usr/local/opt/fzf/"))
  set rtp+=/usr/local/opt/fzf/
elseif !empty(glob("$HOME/.fzf/"))
  set rtp+=$HOME/.fzf/
endif

" Avoid fzf to open files on NERDTree using this func
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! <c-w><c-w>"
  endif
  exe 'normal! ' . a:command_str . "<cr>"
endfunction
nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'

" ripgrep configuration
" Create :Find command"
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

nmap <leader>a :Find 

" Recomendación: Si usas Neovim, usa LSP y plugins modernos como telescope.nvim, nvim-tree.lua, lualine.nvim, etc.
