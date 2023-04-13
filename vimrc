" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" depends: neovim (>=v0.5.0-1b8867ab3), vimplug, ag (>= 2.2.0),
" terraform-ls

" Common settings
syntax on
filetype plugin indent on

" Packages
runtime! macros/matchit.vim

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
Plug 'flazz/vim-colorschemes'            " Colorschemes
Plug 'itchyny/lightline.vim'             " Enhanced status line
Plug 'honza/vim-snippets'                " Preinstalled snippets
Plug 'Shougo/neosnippet.vim'             " Snippets
Plug 'Shougo/neosnippet-snippets'        " Snippet library
Plug 'tpope/vim-fugitive'                " Git integration
Plug 'mbbill/undotree'                   " Undo tree visualizer
Plug 'ggandor/lightspeed.nvim'           " Better and simpler motions
Plug 'tpope/vim-commentary'              " Easy comments
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'                  " Fuzzy finder
Plug 'Shougo/deoplete.nvim'              " Enhanced asynchronous completion
Plug 'Vimjas/vim-python-pep8-indent'     " PEP8-compatible Python indentation
Plug 'Shougo/deoplete-lsp'               " Deoplete integration with LSP
Plug 'nvim-treesitter/nvim-treesitter'   " Treesitter integration
Plug 'nvim-treesitter/nvim-treesitter-refactor' " Refactoring with Treesitter
Plug 'hashivim/vim-terraform'            " Terraform integration
Plug 'tsandall/vim-rego'                 " Rego highlighting
Plug 'towolf/vim-helm'                   " Helm filetype
Plug 'windwp/nvim-spectre'               " Interactive search & replace
Plug 'nvim-lua/plenary.nvim'             " Common dependency for multiple plugins
Plug 'jghauser/mkdir.nvim'               " Automatically create directories
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " Fuzzy finder
Plug 'williamboman/mason.nvim'           " Portable package manager for Neovim
Plug 'williamboman/mason-lspconfig.nvim' " Mason and lspconfig integration
Plug 'neovim/nvim-lspconfig'             " LSP integration with built-in LSP


" Load wakatime plugin if it's configured for this user.
if filereadable(expand("~/.wakatime.cfg"))
    Plug 'wakatime/vim-wakatime'            " Wakatime integration
endif

" On-demand loaded plugins
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep --hidden'
endif

" Styling
" if has('termguicolors')
"   set termguicolors
" endif

" set background=dark
"

colorscheme molokai
let g:molokai_original=1
let python_space_error_highlight = 1     " Python whitespace highlighting.

set cmdheight=1         " Bigger display area for command output.
set showmatch           " Show matching brackets for a short moment.
set mat=1               " Blink matching brackets for tenth of a second.
set laststatus=2        " Always display status line.
set splitbelow          " Splitting a window will put it below the current one.
set splitright          " Splitting a window will put it right of the current one.
set scrolloff=8         " Set scroll offset.
set lazyredraw          " Screen will not be redrawn unnecessarily.
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
set listchars=tab:\ \ ,nbsp:·,trail:·,precedes:←,extends:→
set list                " Show special characters for whitespaces and wrapped lines

" Search settings
set incsearch           " Highlight where the search pattern matches.
set hlsearch            " When there is a previous search pattern, highlight all its matches.
set ignorecase          " Ignore case in search patterns.
set inccommand=nosplit  " In-place preview while substitution.

" Netrw
let g:netrw_banner       = 0             " Hide netrw banner.
let g:netrw_liststyle    = 3             " Change netrw browser list style.
let g:netrw_browse_split = 4             " Open on previous window.
let g:netrw_winsize      = -30
let netrw_browsex_viewer='google-chrome' " Set preferred browser.
" Vex is like Vexplore, but always opens CWD
command! Vex exe 'Vexplore' getcwd()
cnoreabbrev vex Vex

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

" '_' character will not be regarded as part of a word.
set iskeyword-=_

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

"""
""" Global shortcuts
"""

" x removes characters cleanly, not messing up clipboard.
nnoremap x "_x

" X removes a line completely, not messing up clipboard.
nnoremap X "_x
nnoremap XX "_dd

" Map uppercase WQ and the like to lowercase ones.
command W w
command WQ wq
command Wq wq
command Q q

" Make Y copy from cursor to the end of the line
map Y y$

" Keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" Scratch buffer
command! Scratch vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

"""
""" LSP & Treesitter
"""

" LSP integration
:lua << END
    local on_attach = function(client, bufnr)
      vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.diagnostic.open_float({focusable = false})')
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        update_in_insert = false
      }
    )

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {"gopls", "yamlls", "terraformls", "pylsp"}
    })

    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["pylsp"] = function ()
            require("lspconfig").pylsp.setup{
        on_attach=on_attach,
        settings = {
            pyls = {
                plugins = {
                    preload = {
                        enabled = true
                    },
                    pylint = {
                        enabled = true
                    },
                    rope_completion = {
                        enabled = true
                    },
                    yapf = {
                        enabled = true
                    }
                }
            }
        }
    }
        end,
        ["yamlls"] = function ()
            require("lspconfig").yamlls.setup{
                on_attach=on_attach,
                settings = {
                    yaml = {
                        schemas = { kubernetes = {"*.yml", "*.yaml"} }
    }
                }
            }
        end,
        ["gopls"] = function ()
            require("lspconfig").gopls.setup{
        on_attach=on_attach
    }
        end,
        ["terraformls"] = function ()
            require("lspconfig").terraformls.setup{
        on_attach=on_attach,
        filetypes = { "terraform","hcl" }
            }
        end,


    }




END

set signcolumn=yes  " Always show sign column, prevents it from flashing when linter updates
set updatetime=100  " Faster updates for hover/linter

" LSP bindings
nnoremap <silent> <Leader>le    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>ld    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>lh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>lf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <Leader>li    <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> <Leader>lo    <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> <Leader>lr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>ln    <cmd>lua vim.lsp.buf.rename()<CR>

" LSP linter configuration & styling
hi LinterErrorSign ctermfg=199 ctermbg=235
hi LinterWarningSign ctermfg=250 ctermbg=235
call sign_define("LspDiagnosticsSignError", {"text" : "➤", "texthl" : "LinterErrorSign"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "➤", "texthl" : "LinterWarningSign"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "ℹ", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "ℹ", "texthl" : "LspDiagnosticsHint"})

" Treesitter configuration
:lua << END
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained",
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {"python"}
      },
    }

    require'nvim-treesitter.configs'.setup {
      refactor = {
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
      },
    }
END


" Telescope configuration
"
:lua << END
    require('telescope').setup({
      defaults = {
        layout_strategy = "bottom_pane",
        scroll_strategy = "limit",
        layout_config = {
            prompt_position = "bottom",
            height = 25,
        },
      },
    })

builtin = require('telescope.builtin')

function fuzzyFindFiles()
  builtin.grep_string({
    path_display = { 'smart' },
    only_sort_text = true,
    word_match = "-w",
    search = '',
  })
end

END

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


" BIND <Leader> + h to remove trailing whitespaces.
nnoremap <Leader>h :%s/\s\+$//e<CR>

" BIND <Leader> + t* for toggling different options.
nnoremap <silent> <Leader>tv :call VirtualeditToggle()<CR>

""" Toggle functions

function! VirtualeditToggle()
    if &virtualedit == ""
        set virtualedit=all
    else
        set virtualedit=""
    endif
endfunction

""" Plugin bindings

function! SetPluginBindings()
    " Ag abbreviation
    if exists(':Ag')
        cnoreabbrev ag Ag
    endif

    " Telescope bindings
    if exists(':Telescope')
        nnoremap <silent> <Leader>f :Telescope find_files<CR>
        nnoremap <silent> <Leader>b :Telescope buffers<CR>
        nnoremap <silent> <Leader>m :Telescope marks<CR>
        nnoremap <silent> " :Telescope registers<CR>
        nnoremap <silent> <Leader>lr :Telescope lsp_references<CR>
        nnoremap <silent> <Leader>lo :Telescope lsp_outgoing_calls<CR>
        nnoremap <silent> <Leader>li :Telescope lsp_incoming_calls<CR>
        nnoremap <silent> <Leader>lt :Telescope lsp_type_definitions<CR>
        nnoremap <silent> <Leader>ls :Telescope lsp_document_symbols<CR>
        nnoremap <silent> <Leader>a :lua fuzzyFindFiles{}<CR>
    endif

    " vim-go bindings
    if exists(':GoBuild')
        nnoremap <silent> <Leader>ge :GoIfErr<CR>
        nnoremap <silent> <Leader>gr :GoImports<CR>
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

" BIND F4 to toggle line numbers.
silent! nmap <F4> :set invnumber<CR>

"""
""" Custom/helper commands
"""

" Close hidden buffers
" Copied from http://github.com/cakturk/dotfiles
command! CloseHiddenBuffers call <SID>closehiddenbuffers()
function! s:closehiddenbuffers()
    " figure out which buffers are visible in any tab
    let visible = {}
    for t in range(1, tabpagenr('$'))
        for b in tabpagebuflist(t)
            let visible[b] = 1
        endfor
    endfor
    " close any buffer that are loaded and not visible
    let l:tally = 0
    for b in range(1, bufnr('$'))
        if !bufexists(b) || bufname(b) ==# "GoToFile"
            continue
        endif
        if !has_key(visible, b)
            let l:tally += 1
            exe 'bwipeout' . b
        endif
    endfor
    echon "Deleted " . l:tally . " buffers"
endfun

"""
""" Plugin settings
"""

" Editorconfig
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$']}

" Deoplete autocompletion
let g:deoplete#enable_at_startup = 1
set completeopt=menu,menuone,noinsert,noselect

" Neosnippets
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#snippets_directory = '~/.vim/mysnippets'

" SuperTab-like snippets behavior
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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

" Lightline settings.
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v%<',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGitbranch',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'n/a') : ''
endfunction

function! LightlineGitbranch()
  return winwidth(0) > 90 ? fugitive#head()[0:10] : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" vim-go settings
let g:go_fmt_fail_silently = 1
let g:go_gopls_enabled = 0     " Built-in LSP will be used

" terraform
let g:terraform_fmt_on_save=1
