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
set cursorline

" Magic from the internet (https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f)
" <MAGIC>
function! MyHighlights() abort
    highlight Normal NONE 
    highlight NonText NONE
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END
" </MAGIC>

call plug#begin('~/.vim/plugged')
	" GENERAL
	Plug 'tpope/vim-sensible'
	Plug 'airblade/vim-gitgutter'
	Plug 'scrooloose/nerdtree'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'itchyny/lightline.vim'
	Plug 'ervandew/supertab'
	let g:lightline = { 'colorscheme' : 'wombat'}
	map <C-n> :NERDTreeToggle<CR>

	" SYNTAX
	Plug 'leafgarland/typescript-vim'
	Plug 'jelera/vim-javascript-syntax'
	Plug 'justinmk/vim-syntax-extra'

	" COLORSCHEMES
	Plug 'dunckr/vim-monokai-soda'
	Plug 'sfi0zy/atlantic-dark.vim'
	Plug 'koirand/tokyo-metro.vim'
	Plug 'vim-scripts/Gummybears'
call plug#end()

" colorscheme monokai-soda
" colorscheme atlantic-dark
" colorscheme tokyo-metro
colorscheme gummybears

" SIMPL
au BufRead,BufNewFile *.simpl setfiletype simpl
au FileType simpl set autoindent expandtab softtabstop=4 shiftwidth=4 tabstop=4 textwidth=80
set hlsearch
