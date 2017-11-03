" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" Depends: vim (>=8) (+python, +clipboard), vimplug, 
" exuberant-ctags, ilversearcher-ag (>= 0.29.1)

" Common settings
set nocompatible
syntax on
filetype plugin indent on

" Packages
" Some packages require Python support for vim: sirver/ultisnips,
" sjl/gundo.vim, lambdalisue/vim-gista, lambdalissue/vim-gista-ctrlp.
" Debian 'vim' package does not support Python. Try 'vim-nox' package or add
" necessary flags to the debian/rules file of the 'vim' package and recompile.

" Packadd packages
if v:version >= 800
    packadd! matchit
endif

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
Plug 'neomake/neomake' | Plug 'dojoteef/neomake-autolint' " Asynchronous jobs & linter
" Plug 'w0rp/ale'                         " Asynchronous syntax checking
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'jistr/vim-nerdtree-tabs'          " better NERDTree and tabs integration
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
Plug 'easymotion/vim-easymotion'        " Better and simple motions
Plug 'ahw/vim-hooks'                    " Shell script hooks into autocmd events
Plug 'tpope/vim-commentary'             " Easy comments
Plug 'Shougo/neocomplete.vim'           " Enhanced and automatic completion
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'                 " Fuzzy finder
Plug 'sheerun/vim-polyglot'             " Collection of language packs
Plug 'junegunn/vim-peekaboo'            " Display Vim registers

" Load wakatime plugin if its configured for this user.
if filereadable(expand("~/.wakatime.cfg"))
    Plug 'wakatime/vim-wakatime'            " Wakatime integration
endif

" On-demand loaded plugins
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
call plug#end()


" Styling
colorscheme molokai
let g:molokai_original = 1
let g:netrw_liststyle=1 " Change netrw browser list style.
"  I like these options, yet Vim works slow with tmux and iTerm2
"  if these are enabled. (not saying it works great even after
"  disabling them. :/ )
" set cursorline          " Highlight current line.
" set showcmd             " Show incomplete command in the lower right corner of Vim.
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
set ssop-=options       " Not saving session-spesific options, as they become an annoyance later.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Search settings
set incsearch           " Highlight where the search pattern matches.
set hlsearch            " When there is a previous search pattern, highlight all its matches.
set ignorecase          " Ignore case in search patterns.

" " Clipboard support
" if has('clipboard')
"     if has('unix')
"         set clipboard^=unnamedplus
"     endif
" endif

" Directories
set undodir=~/.vim/.undo/       " Persistent undo history directory.
set backupdir=~/.vim/.backup//   " Backup directory.
set directory=~/.vim/.swp//      " Swap file directory.

if exists('*mkdir')
    if !isdirectory(&undodir)
        call mkdir(&undodir)
    endif

    if !isdirectory(&backupdir)
        call mkdir(&backupdir)
    endif

    if !isdirectory(&directory)
        call mkdir(&directory)
    endif
endif

" Enable undo, backup and swap files.
set undofile
set backup
set swapfile

" Set leader key to SPACE.
let mapleader=" "

" Show visual cues for wrapped lines.
if has('linebreak')
  try
    set breakindent
    let &showbreak='↳'
  catch /E518:/
    " Unknown option: breakindent
  endtry
endif

" Resize all splits on all tabs when Vim window is resized.
" Thanks to: http://github.com/cakturk
command! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)

augroup resize_splits
    autocmd!
    autocmd VimResized * Tabdo wincmd =
augroup END

function! TabDo(command)
    let l:currTab=tabpagenr()
    execute 'tabdo ' . a:command
    execute 'tabn ' . currTab
endfunction

" Set preferred browser.
let netrw_browsex_viewer='google-chrome'

"""
""" Global shortcuts
"""

" x removes characters cleanly, not messing up clipboard.
nnoremap x "_d 


" X removes a line completely, not messing up clipboard.
nnoremap X "_d
nnoremap XX "_dd

" Map uppercase WQ and the like to lowercase ones.
command W w
command WQ wq
command Wq wq
command Q q

"""
""" <Leader> shortcuts
"""

" BIND <Leader> + <LEFTARR/RIGHTARR/ENTER> for tab management.
nnoremap <Leader><Right> :tabn<CR>
nnoremap <Leader><Left> :tabp<CR>
nnoremap <Leader><CR>  :tab split<CR>

" BIND <Leader> + <BACKSPACE> to dismiss highlighting.
function SetLeaderBackspace()
    nnoremap <Leader><BACKSPACE> :nohl<CR>
endfunction

au VimEnter * call SetLeaderBackspace()

" BIND <Leader> + v to Vsplit, c to Split.
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>c :split<CR>

" BIND <Leader> + PageUp/PageDown for managing buffers.
nnoremap <Leader><PageUp> :bn<CR>
nnoremap <Leader><PageDown> :bp<CR>
nnoremap <Leader><Delete> :bd<CR>

""" Plugin bindings

function! SetPluginBindings()
    " BIND <Leader> + t to TagBar.
    if exists(':Tagbar')
        nnoremap <Leader>t :Tagbar<CR>
    endif

    " BIND <Leader> + u to Gundo.vim toggle.
    if exists(':GundoToggle')
        nnoremap <Leader>u :GundoToggle<CR>
    endif

    if exists(':Gista')
    " BIND <F6> to Gista list.
        nnoremap <F6> :Gista list<CR>
    endif

    if exists(':Neomake')
    " BIND <F10> to start Neomake build.
        nnoremap <F10> :Neomake!<CR>
    endif

    if exists(':NeoCompleteToggle')
    " BIND <F12> to toggle NeoComplete completion.
        nnoremap <F12> :NeoCompleteToggle<CR>
    endif

    if exists(':FZF')
    " FZF Bindings.
        nnoremap <silent> <c-p> :FZF<CR>
        nnoremap <silent> <Leader>/ :BLines<CR>
        nnoremap <silent> <Leader>l :Lines<CR>
        nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
    endif
endfunction

au VimEnter * call SetPluginBindings()

" Prefer vim-go if exists for Golang files.
autocmd Filetype go if exists(':GoBuild') | map <buffer> <F10> :GoBuild<CR> | endif
autocmd Filetype go if exists(':GoRun') | map <buffer> <F9> :GoRun<CR> | endif

"""
""" Function key bindings
"""

" BIND F2 to Paste Mode.
" This binding will be overriden if Bracketed Paste plugin is enabled.
set pastetoggle=<F2>

" BIND F4 to Inspection Mode. :)
silent! nmap <F4> :set invnumber<CR>:set invlist<CR>
set listchars=tab:>.,nbsp:·,trail:·,precedes:←,extends:→

" BIND F5 to Buffer menu.
autocmd VimEnter * call SetBufferMenu()
function SetBufferMenu()
    if exists(':FZF')
        nnoremap <F5> :Buffers<CR>
    else
        " Old fashioned way.
        nnoremap <F5> :buffers<CR>:buffer<Space>
    endif
endfunction

"""
""" Plugin settings
"""

" Neomake(-autolint) settings.
let g:neomake_error_sign = {
            \ 'text': '➤',
            \ 'texthl': 'ErrorMsg',
            \ }
hi ErrorMsg ctermbg=235
hi MyWarningMsg ctermfg=250 ctermbg=235
let g:neomake_warning_sign = {
            \ 'text': '➤',
            \ 'texthl': 'MyWarningMsg',
            \ }

" NeoComplete settings.
let g:neocomplete#max_list = 20
let g:neocomplete#enable_auto_close_preview = 1

" NerdTREE settings.
let g:NERDTreeRespectWildIgnore=1
silent! nnoremap <F3> :NERDTreeTabsToggle<CR>

" UltiSnips settings.
let g:UltiSnipsNoPythonWarning = 1
let g:snips_author = 'Yekta Leblebici <yekta@iamyekta.com>'
let g:UltiSnipsSnippetsDir = '~/.vim/mysnippets'

" Vim-Gista settings.
let g:gista#command#post#default_public = 0

" fzf-vim settings.
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
             \ 'header':  ['fg', 'Comment']
             \ }

let g:fzf_buffers_jump = 1

let g:fzf_layout = { 'down': '~30%' }

" Airline settings.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Default symbol was not shown correctly on rxvt with Hack font.
" Just replacing it with a similar Powerline character.
let g:airline_symbols.maxlinenr = ' '

" OS X spesific configuration
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
      " iTerm 2 scroll wheel support, somehow does not work if mouse mode not
      " set.
      set mouse=a

      " OS X clipboard support
      if has("clipboard")
          set clipboard^=unnamed
      endif

      " Workaround for UltiSnips throwing errors on Insert mode.
      " au! UltiSnips_AutoTrigger
  endif
endif

" " ALE settings. Uncomment if ALE is enabled.
"  let g:ale_sign_error = '➤'
"  let g:ale_sign_warning = '➤'
"  hi ALEErrorSign ctermfg=199 ctermbg=235
"  hi ALEWarningSign ctermfg=250 ctermbg=235
"  let g:ale_echo_msg_error_str = 'E'
"  let g:ale_echo_msg_warning_str = 'W'
"  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"  let g:ale_sign_column_always = 1
"  let g:ale_emit_conflict_warnings = 0
"  hi ALEError cterm=underline,bold
"  hi ALEWarning cterm=underline,bold
"  hi ALEInfo cterm=underline,bold

" Airline settings.
" Airline buffer tab view. Uncomment to enable.
"let g:airline#extensions#tabline#enabled = 1
"
" Show filenames only. Uncomment to enable.
"let g:airline#extensions#tabline#fnamemod = ':t'
