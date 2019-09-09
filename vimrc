" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" depends: neovim (>=0.3.8) || vim (>=8.1) (+python, +clipboard), vimplug,
" silversearcher-ag (>= 0.29.1)

" Common settings
set nocompatible
syntax on
filetype plugin indent on

" Packages
" Some packages require +python3 support.
" Packadd packages
if has('nvim')
  runtime! macros/matchit.vim
else
    if v:version >= 800
        packadd! matchit
    endif
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
Plug 'flazz/vim-colorschemes'           " Colorschemes
Plug 'w0rp/ale'                         " Asynchronous syntax checking
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'jistr/vim-nerdtree-tabs'          " better NERDTree and tabs integration
Plug 'vim-airline/vim-airline'          " Enhanced status line
Plug 'ConradIrwin/vim-bracketed-paste'  " Automatic paste mode
Plug 'terryma/vim-multiple-cursors'     " Multiple cursors, like Sublime Text
Plug 'sirver/ultisnips'                 " Snippet support
Plug 'honza/vim-snippets'               " Preinstalled snippets
Plug 'tpope/vim-fugitive'               " Git integration
Plug 'mbbill/undotree'                  " Undo tree visualizer
Plug 'easymotion/vim-easymotion'        " Better and simple motions
Plug 'tpope/vim-commentary'             " Easy comments
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'                 " Fuzzy finder
" For some reason, polyglot Python syntax highlighter became dog slow,
" and made a lot of intrusive changes. I am pinning it for now.
Plug 'sheerun/vim-polyglot', { 'commit': '11f5325' } " Collection of language packs
Plug 'junegunn/vim-peekaboo'            " Display Vim registers
Plug 'Shougo/deoplete.nvim'             " Enhanced asynchronous completion
Plug 'Shougo/echodoc.vim'
Plug 'sgur/vim-editorconfig'            " Editorconfig integration in VimScript
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }  " Table alignment
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }                                 " LSP integration

if !has('nvim')
    Plug 'roxma/nvim-yarp'                  " Nvim compatibility plugin
    Plug 'roxma/vim-hug-neovim-rpc'         " Nvim compatibility plugin
endif
" Load wakatime plugin if its configured for this user.
if filereadable(expand("~/.wakatime.cfg"))
    Plug 'wakatime/vim-wakatime'            " Wakatime integration
endif

" On-demand loaded plugins
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Styling
colorscheme molokai
let g:molokai_original=1
let g:netrw_banner=0    " Hide netrw banner.
let g:netrw_liststyle=3 " Change netrw browser list style.
let g:netrw_browse_split=4 " Open on previous window.
let g:netrw_winsize = -30

"  I like these options, yet Vim works slow with tmux if these are enabled.
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
set noshowmode          " Remove --INSERT-- line from bottom.

" Convenience
set hidden
set tabstop=4           " Number of spaces that a <Tab> counts for. Default is 8.
set shiftwidth=4        " Number of spaces to use for each step of indentation.
set expandtab           " Spaces are used instead of <Tab>. To insert a real tab, use CTRL-V<Tab>
set copyindent          " Copy the structure of existing lines indent when autoindenting.
set wildmenu            " Enable enhanced command-line completion.
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj " Ignore these patterns on completion.
set undolevels=1000     " Maximum number of changes that can be undone.
set history=100         " Maximum number of command and search patterns history.
set autoindent          " Copy indent from current line when starting a new line.
set smartindent         " Smart autoindenting when starting a new line.
set backspace=indent,eol,start " Sane backspace options.
set encoding=utf-8      " Encoding
set cinkeys-=0#         " Remove # symbol from reindentation list.
set indentkeys-=0#      " Remove # symbol from reindentation list.
set cinoptions=l1       " Change Vim indentation behaviour. See: cinoptions-values
set formatoptions+=j    " Delete comment character when joining commented lines.
set ssop-=options       " Not saving session-spesific options, as they become an annoyance later.
set fillchars=vert:│,fold:─ " Splits look a bit prettier.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set mouse=a             " Enable mouse support.
set nomodeline          " Disable modeline, more convenient and secure.
set noautoread          " Don't autoread changes made to files outside of vim.
set belloff=all         " Disable bell completely.
set complete=w,b,u,t,i  " Completion behavior.
set fsync               " Every :w is followed by fsync()
set shortmess=filnxtToOF " Messages to be avoided.
set noshowcmd           " Don't show command in the last line of the screen.
set nosmarttab          " Tab always inserts blanks according to 'tabstop' or 'softtabstop'.


" Search settings
set incsearch           " Highlight where the search pattern matches.
set hlsearch            " When there is a previous search pattern, highlight all its matches.
set ignorecase          " Ignore case in search patterns.

" OS specific configuration
if has('unix')
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"

      " OS X clipboard support
      if has('clipboard')
          set clipboard^=unnamed
      endif

  endif

  if s:uname == "Linux\n"

     " Linux clipboard support
     if has('clipboard')
        set clipboard^=unnamedplus
     endif

  endif
endif

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

""" EasyMotion bindings
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Most useful one, and I never use 's' key:
nmap s <Plug>(easymotion-s2)

" I might want this later, but today I feel like it matches
" a little too much on a 4K screen.
" let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

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

" BIND <Leader> + h to remove trailing whitespaces.
nnoremap <Leader>h :%s/\s\+$//e<CR>

""" Plugin bindings

function! SetPluginBindings()

    " Ag abbreviation
    if exists(':Ag')
        cnoreabbrev ag Ag
    endif

    " Bind <Leader> + u to Gundo.vim toggle.
    if exists(':GundoToggle')
        nnoremap <Leader>u :GundoToggle<CR>
    endif

    " FZF bindings
    if exists(':FZF')
        nnoremap <silent> <Leader>f :FZF<CR>
        nnoremap <silent> <Leader>b :Buffers<CR>
        nnoremap <silent> <Leader>l :Lines<CR>
        nnoremap <silent> <Leader>m :Marks<CR>
    endif

    " vim-go bindings
    if exists(':GoBuild')
        nnoremap <silent> <Leader>ge :GoIfErr<CR>
        nnoremap <silent> <Leader>gr :GoImports<CR>
    endif

    " ALE bindings
    if exists(':ALEInfo')
        nnoremap <silent> <Leader>af :ALEFix<CR>
    endif

endfunction

au VimEnter * call SetPluginBindings()

" Prefer vim-go if exists for Golang files.
autocmd Filetype go if exists(':GoBuild') | map <buffer> <F10> :GoBuild<CR> | endif
autocmd Filetype go if exists(':GoRun') | map <buffer> <F9> :GoRun<CR> | endif

" FZF :Registers
function! GetRegisters()
  redir => cout
  silent registers
  redir END
  return split(cout, "\n")[1:]
endfunction
function! UseRegister(line)
  let var_a = getreg(a:line[1], 1, 1)
  call append(line('.'), var_a)
endfunction
command! Registers call fzf#run(fzf#wrap({
        \ 'source': GetRegisters(),
        \ 'sink': function('UseRegister')}))

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

" Editorconfig
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$']}

" Deoplete settings
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" NerdTREE settings.
let g:NERDTreeRespectWildIgnore=1
silent! nnoremap <F3> :NERDTreeTabsToggle<CR>

" UltiSnips settings.
let g:UltiSnipsNoPythonWarning = 1
let g:snips_author = 'Yekta Leblebici <yekta@iamyekta.com>'
let g:UltiSnipsSnippetsDir = '~/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories = ["UltiSnips", $HOME.'/.vim/mysnippets']

" Gundo.vim settings.
let g:gundo_prefer_python3 = 1

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

" LanguageClient settings
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" LanguageClient bindings
nnoremap <silent> <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <Leader>lf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <Leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <Leader>ln :call LanguageClient_textDocument_rename()<CR>

" LanguageClient linter
let g:LanguageClient_diagnosticsDisplay =  {
            \ 1: {
            \ "name": "Error",
            \ "texthl": "ALEError",
            \ "signText": "➤",
            \"signTexthl": "ALEErrorSign",
            \ },
            \ 2: {
            \ "name": "Warning",
            \ "texthl": "ALEWarning",
            \ "signText": "➤",
            \ "signTexthl": "ALEWarningSign",
            \ },
            \ 3: {
            \ "name": "Information",
            \ "texthl": "ALEInfo",
            \ "signText": "ℹ",
            \  "signTexthl": "ALEInfoSign",
            \  },
            \  4: {
            \ "name": "Hint",
            \ "texthl": "ALEInfo",
            \ "signText": "ℹ",
            \ "signTexthl": "ALEInfoSign",
            \ },
            \ }

let g:LanguageClient_diagnosticsEnable = 0

" ALE settings
let g:ale_sign_error = '➤'
let g:ale_sign_warning = '➤'
hi ALEErrorSign ctermfg=199 ctermbg=235
hi ALEWarningSign ctermfg=250 ctermbg=235
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
let g:ale_emit_conflict_warnings = 0
hi ALEError cterm=underline,bold
hi ALEWarning cterm=underline,bold
hi ALEInfo cterm=underline,bold

" let g:ale_linters = {
" \   'python': ['flake8', 'pylint'],
" \}

let g:ale_linters = {
\   'python': ['pyls'],
\   'yaml': ['yamllint'],
\}

let g:ale_type_map = {
\  'flake8' : { 'ES': 'WS', 'E': 'W'},
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf', 'isort'],
\   'yaml': ['prettier'],
\}

" vim-go settings
let g:go_fmt_fail_silently = 1 " Using ALE for syntax checking.
