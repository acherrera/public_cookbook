set nocompatible              " be iMproved, required
filetype off                  " required
set shell=bash " required for fish shell

"==== THE MOST IMPORTANT =====
imap jk <Esc>
" set nu rnu
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')

" Testing
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" The good Stuff
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'psf/black'
Plug 'https://github.com/chrisbra/Colorizer'
Plug 'https://github.com/dag/vim-fish'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Don't forget to :CocInstall coc-python
" and enable linting the whole line
Plug 'preservim/nerdtree'

Plug 'christoomey/vim-tmux-navigator' " ctrl+h and ctr+j movement


" Colorschemes
Plug 'flazz/vim-colorschemes'
hi Normal guibg=NONE ctermbg=NONE
call plug#end()



" ========================== Personal Settings ===================

" For fzf
set rtp+=/home/tony/programs/fzf/bin/fzf

" Colors!
syntax enable
set background=dark
set termguicolors

set number
let python_highlight_all=1
syntax on
set incsearch
set nohlsearch

"This wil allow the tab complete file finder to work ============
set path+=**
set wildmenu

" This is for tab spacing =====================================
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set fileformat=unix

"For YCM =================================================
" let g:ycm_python_binary_path = '/usr/bin/python3'
" let g:ycm_autoclose_preview_window_after_completion=2
" let g:ycm_server_python_interpreter = '/usr/bin/python3'

" Always show statuslie =========================================
set laststatus=2

" Codear
" folding
set foldmethod=indent
" set foldnestmax=3

" Does not recognize custom colors until down here
colorscheme molokai
" transparenty backgroun
" hi Normal guibg=NONE ctermbg=NONE

" Remap the leader
let mapleader=","

""""""""""""" EasyMotion configuration """""""""""""""
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" up, down, left, right
map <Leader>w <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>b <Plug>(easymotion-linebackward)


" Treat Arduino files like C++. Tab correction
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Add python debugging to program and remove easily - freaking awesome!
nnoremap +d Oimport pudb; pudb.set_trace()<esc>0j

" Mouse mode and clipboard that make sense
set clipboard=unnamedplus
set mouse=a


" ##### Personal Cheat sheet #####
" Quick reference stuff I should know

" ##### Vim splits
" " Resizing 
" " Max out the height of the current split
" ctrl + w _
" " Max out the width of the current split
" ctrl + w |
" " Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =

" 
" ##### Swapping splits
" " Swap top/bottom or left/right split
" Ctrl+W R
" " Break out current window into a new tabview
" Ctrl+W T
" " Close every window in the current tabview but the current one
" Ctrl+W o


" Spellcheck when writing markdown
autocmd FileType markdown setlocal spell

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=*.pyc
set wildignore+=node_modules/*,bower_components/*

" What? 
"map <C-n> :set number!<CR>

" Make set tags work
set tags=tags;/


" ###### Vim Splits - Transcend #####
" Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Better Opening
set splitbelow
set splitright

" Easy vertical Splits
nnoremap <silent> vv <C-w>v


""""""""""""""""""""""""" NOTES """"""""""""""""""""""""""

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" FZF configuration
"nmap <Leader>g :Buffer<CR>
nmap <Leader>B :Buffer<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
