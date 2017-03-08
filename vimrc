" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" Depends: vim (>=8) (+python), vimplug, exuberant-ctags, 
" silversearcher-ag (>= 0.29.1)

" Common settings
"execute pathogen#infect()
set nocompatible
syntax on
filetype plugin indent on

" Packages
" Some packages require Python support for vim: sirver/ultisnips, 
" sjl/gundo.vim, lambdalisue/vim-gista, lambdalissue/vim-gista-ctrlp.
" Debian 'vim' package does not support Python. Try 'vim-nox' package or add
" necessary flags to the debian/rules file of the 'vim' package and recompile.
packadd! matchit

call plug#begin('~/.vim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-multiple-cursors'
Plug 'majutsushi/tagbar'
Plug 'gabesoft/vim-ags'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
"Plug 'tpope/vim-sleuth'
Plug 'lambdalisue/vim-gista' 
Plug 'lambdalisue/vim-gista-ctrlp'
Plug 'easymotion/vim-easymotion'
Plug 'ahw/vim-hooks'
call plug#end()

" Styling
colorscheme molokai
let g:molokai_original = 1
set cursorline
let g:netrw_liststyle=1
set cmdheight=2
set showmatch
set laststatus=2
set splitbelow
set splitright
set scrolloff=8

" Convenience
set tabstop=4
"set softtabstop=4
set shiftwidth=4
set copyindent
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj
set undolevels=1000
set lazyredraw
set autoindent
set smartindent
set backspace=indent,eol,start
set encoding=utf-8
set cinkeys-=0#
set indentkeys-=0#
set cinoptions=l1
set ttyfast

" Search settings
set incsearch
set hlsearch
set ignorecase

" Directories
" MAKE SURE THEY EXIST!
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//


" Delete comment character when joining commented lines.
set formatoptions+=j

" Faster switching from insert mode.
set ttimeoutlen=10

" Set leader key to SPACE.
let mapleader=" "

" Automatically scale internal windows on terminal resize.
autocmd VimResized * :wincmd =

" Show incomplete command in the lower right corner of Vim.
set showcmd

" Blink matching brackets for tenth of a second.
set mat=1

" Show visual cues for wrapped lines
if has('linebreak')
  try
    set breakindent
    let &showbreak='↳'
  catch /E518:/
    " Unknown option: breakindent
  endtry
endif

" Windows, Tabs and Buffers.
set switchbuf=useopen,usetab,newtab
set stal=1

"""
""" <Leader> shortcuts
"""

" BIND <Leader> + <LEFTARR/RIGHTARR/ENTER> for tab management.
nnoremap <Leader><Right> :tabn<CR>
nnoremap <Leader><Left> :tabp<CR>
nnoremap <Leader><CR>  :tab split<CR>

" BIND <Leader> + <BACKSPACE> to dismiss highlighting.
nnoremap <Leader><BACKSPACE> :nohl<CR>

" BIND <Leader> + v to Vsplit, c to Split.
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>c :split<CR>

" BIND <Leader> + PageUp/PageDown for managing buffers.
nnoremap <Leader><PageUp> :bn<CR>
nnoremap <Leader><PageDown> :bp<CR>
nnoremap <Leader><Delete> :bd<CR>

""" <Leader> - Plugin bindings

function! SetPluginBindings()
    " BIND <Leader> + t to TagBar.
    if exists(':Tagbar')
        nnoremap <Leader>t :Tagbar<CR>
    endif

    " BIND <Leader> + u to Gundo.vim toggle.
    if exists(':GundoToggle')
        nnoremap <Leader>u :GundoToggle<CR>
    endif

    if exists(':CtrlPGista')
    " BIND <F6> to CtrlP Gista view.
    	nnoremap <F6> :CtrlPGista<CR>
    endif
endfunction

au VimEnter * call SetPluginBindings()

" BIND F2 to Paste Mode.
" This binding will be overriden if Bracketed Paste plugin is enabled.
set pastetoggle=<F2>

" BIND F4 to Inspection Mode. :)
silent! nmap <F4> :set invnumber<CR>:set invlist<CR>
set listchars=tab:>.,nbsp:·,trail:·,precedes:←,extends:→

" BIND F5 to Buffer menu.
autocmd VimEnter * call SetBufferMenu()
function SetBufferMenu()
    if exists(':CtrlPBuffer')
        nnoremap <F5> :CtrlPBuffer<CR>
    else 
        " Old fashioned way.
        nnoremap <F5> :buffers<CR>:buffer<Space> 
    endif
endfunction

"""
""" Plugin settings
"""

" BEGIN Syntastic settings.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" END Syntastic settings.

" BEGIN NerdTREE settings.
let g:NERDTreeRespectWildIgnore=1
"silent! nnoremap <Leader>p :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

" BIND F3 to NERDTree.
let g:NERDTreeMapActivateNode="<F3>"
" END NerdTREE settings.

" BEGIN Gist.vim settings.
"let g:gist_detect_filetype = 1
"let g:gist_show_privates = 1
"let g:gist_post_private = 1
"let g:gist_list_vsplit = 1
" END Gist.vim settings.

" BEGIN Vim-Gista settings.
let g:gista#command#post#default_public = 0 
" END Vim-Gista settings.

" BEGIN Airline settings.
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_left_alt_sep = ''
" END Airline settings.


" Airline buffer tab view. Uncomment to enable.
"let g:airline#extensions#tabline#enabled = 1
"
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
