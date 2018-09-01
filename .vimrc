filetype plugin on
syntax on
set textwidth=80
set tabstop=4
set shiftwidth=4
set autoindent
set number
set relativenumber
set termguicolors
set noshowmode

" SIMPL
au BufRead,BufNewFile *.simpl setfiletype simpl
au FileType simpl set autoindent expandtab softtabstop=4 shiftwidth=4 tabstop=4 textwidth=80
set hlsearch

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'dunckr/vim-monokai-soda'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'leafgarland/typescript-vim'
" Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
call plug#end()

let g:lightline = { 'colorscheme' : 'wombat'}

map <C-n> :NERDTreeToggle<CR>
colorscheme monokai-soda
hi Normal guibg=NONE ctermbg=NONE ctermfg=NONE
hi NonText ctermbg=NONE guibg=NONE ctermfg=NONE
