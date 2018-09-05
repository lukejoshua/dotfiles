call plug#begin('~/.vim/plugged')
	Plug 'tpope/vim-sensible'
	Plug 'airblade/vim-gitgutter'
	Plug 'scrooloose/nerdtree'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'itchyny/lightline.vim'
	Plug 'ervandew/supertab'

	" SYNTAX
	Plug 'leafgarland/typescript-vim'
	Plug 'jelera/vim-javascript-syntax'
	Plug 'justinmk/vim-syntax-extra'
	" Plug 'pangloss/vim-javascript'

	" COLORSCHEMES
	Plug 'dunckr/vim-monokai-soda'
	Plug 'sfi0zy/atlantic-dark.vim'
	Plug 'koirand/tokyo-metro.vim'
	Plug 'vim-scripts/Gummybears'
call plug#end()

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
" set cursorline

let g:lightline = { 'colorscheme' : 'wombat'}

map <C-n> :NERDTreeToggle<CR>
" colorscheme monokai-soda
" colorscheme atlantic-dark
" colorscheme tokyo-metro
colorscheme gummybears
hi Normal guibg=NONE ctermbg=NONE ctermfg=NONE
hi NonText ctermbg=NONE guibg=NONE ctermfg=NONE

" SIMPL
au BufRead,BufNewFile *.simpl setfiletype simpl
au FileType simpl set autoindent expandtab softtabstop=4 shiftwidth=4 tabstop=4 textwidth=80
set hlsearch
