" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" Depends: vim (>=8) (+python), vimplug, exuberant-ctags, 
" silversearcher-ag (>= 0.29.1)

" Common settings
set nocompatible
syntax on
filetype plugin indent on

" Packages
" Some packages require Python support for vim: sirver/ultisnips, 
" sjl/gundo.vim, lambdalisue/vim-gista, lambdalissue/vim-gista-ctrlp.
" Debian 'vim' package does not support Python. Try 'vim-nox' package or add
" necessary flags to the debian/rules file of the 'vim' package and recompile.
packadd! matchit

" Install vim-plug if not installed already.
let s:vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(s:vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let s:loading_plugins = "yes"
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'                   " Colorscheme
Plug 'kien/ctrlp.vim'                   " CTRL+P file search
Plug 'ekalinin/Dockerfile.vim'          " Dockerfile file type
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'jistr/vim-nerdtree-tabs'          " better NERDTree and tabs integration
Plug 'vim-syntastic/syntastic'          " Syntax checker
Plug 'vim-airline/vim-airline'          " Enhanced status line
Plug 'ConradIrwin/vim-bracketed-paste'  " Automatic paste mode
Plug 'terryma/vim-multiple-cursors'     " Multiple cursors, like  Sublime Text
Plug 'majutsushi/tagbar'                " Tag browser, ordered by scope
Plug 'gabesoft/vim-ags'                 " Ag integration
Plug 'sirver/ultisnips'                 " Snippet support
Plug 'honza/vim-snippets'               " Preinstalled snippets
Plug 'tpope/vim-fugitive'               " Git integration
Plug 'sjl/gundo.vim'                    " Undo tree visualizer
Plug 'lambdalisue/vim-gista'            " Github Gists support
Plug 'lambdalisue/vim-gista-ctrlp'      " Gists and CTRL+P integration
Plug 'easymotion/vim-easymotion'        " Better and simple motions
Plug 'ahw/vim-hooks'                    " Shell script hooks into autocmd events
call plug#end()

" Styling
colorscheme molokai
let g:molokai_original = 1
set cursorline          " Highlight current line.
let g:netrw_liststyle=1 " Change netrw browser list style.
set showcmd             " Show incomplete command in the lower right corner of Vim.
set cmdheight=2         " Bigger display area for command output.
set showmatch           " Show matching brackets for a short moment.
set mat=1               " Blink matching brackets for tenth of a second.
set laststatus=2        " Always display status line.
set splitbelow          " Splitting a window will put it below the current one.
set splitright          " Splitting a window will put it right of the current one.
set scrolloff=8         " Set scroll offset.
set lazyredraw          " Screen will not be redrawn unnecessarily.
set ttyfast             " Improve smoothness of redrawing on a fast terminal connection.
set ttimeoutlen=10      " Faster switching from insert mode.
set stal=1              " Show tab page labels only if there are at least two tab pages.
set switchbuf=useopen,usetab,newtab " Change behavior when switching between buffers.
autocmd VimResized * :wincmd =      " Automatically scale internal windows on terminal resize.

" Convenience
set tabstop=4           " Number of spaces that a <Tab> counts for. Default is 8.
set shiftwidth=4        " Number of spaces to use for each step of indentation.
set expandtab           " Spaces are used instead of <Tab>. To insert a real tab, use CTRL-V<Tab>
set copyindent          " Copy the structure of existing lines indent when autoindenting.
set wildmenu            " Enable enhanced command-line completion.
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj " Ignore these patterns on completion.
set undolevels=1000     " Maximum number of changes that can be undone.
set autoindent          " Copy indent from current line when starting a new line.
set smartindent         " Smart autoindenting when starting a new line.
set backspace=indent,eol,start " Sane backspace options.
set encoding=utf-8      " Encoding
set cinkeys-=0#         " Remove # symbol from reindentation list.  
set indentkeys-=0#      " Remove # symbol from reindentation list.
set cinoptions=l1       " Change Vim indentation behaviour. See: cinoptions-values
set formatoptions+=j    " Delete comment character when joining commented lines.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Search settings
set incsearch           " Highlight where the search pattern matches.
set hlsearch            " When there is a previous search pattern, highlight all its matches.
set ignorecase          " Ignore case in search patterns.

" Clipboard support
if has('clipboard')
    if has('unix')
        set clipboard^=unnamedplus
    endif
endif

" Directories
" MAKE SURE THEY EXIST!
set undodir=~/.vim/.undo//       " Persistent undo history directory.
set backupdir=~/.vim/.backup//   " Backup directory.
set directory=~/.vim/.swp//      " Swap file directory.

" Set leader key to SPACE.
let mapleader=" "

" Show visual cues for wrapped lines
if has('linebreak')
  try
    set breakindent
    let &showbreak='↳'
  catch /E518:/
    " Unknown option: breakindent
  endtry
endif

"""
""" <Leader> shortcuts
"""

" BIND <Leader> + <LEFTARR/RIGHTARR/ENTER> for tab management.
nnoremap <Leader><Right> :tabn<CR>
nnoremap <Leader><Left> :tabp<CR>
nnoremap <Leader><CR>  :tab split<CR>

" BIND <Leader> + <BACKSPACE> to dismiss highlighting and syntax checking.
function SetLeaderBackspace()
    if exists(':SyntasticReset')
        nnoremap <Leader><BACKSPACE> :nohl<CR>:SyntasticReset<CR>
    else
        nnoremap <Leader><BACKSPACE> :nohl<CR>
endif
endfunction

au VimEnter * call SetLeaderBackspace()

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
silent! nnoremap <F3> :NERDTreeTabsToggle<CR>
" END NerdTREE settings.

" BEGIN Vim-Gista settings.
let g:gista#command#post#default_public = 0 
" END Vim-Gista settings.

" BEGIN UltiSnips settings.
let g:UltiSnipsNoPythonWarning = 1
let g:snips_author = 'Yekta Leblebici <yekta@iamyekta.com>'
let g:UltiSnipsSnippetsDir = '~/.vim/mysnippets'
" END UltiSnips settings.

" Airline buffer tab view. Uncomment to enable.
"let g:airline#extensions#tabline#enabled = 1
"
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
