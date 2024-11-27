" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" depends: neovim (>=v0.10.0), ag (>= 2.2.0), rg (>=13.0.0)

:lua << END
-- Common settings
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- Packages
vim.cmd('runtime! macros/matchit.vim')

-- Set leader key to space
-- setting `mapleader` before lazy.nvim so mappings are correct
vim.g.mapleader = " "

-- Lazy.nvim package management

-- Ensure lazy.nvim exists
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy").setup({
    {'flazz/vim-colorschemes',                                   desc = 'Colorschemes'},
    {'itchyny/lightline.vim',                                    desc = 'Enhanced status line'},
    {'honza/vim-snippets',                                       desc = 'Preinstalled snippets'},
    {'tpope/vim-fugitive',                                       desc = 'Git integration'},
    {'mbbill/undotree',                                          desc = 'Undo tree visualizer'},
    {'ggandor/leap.nvim',                                        desc = 'Better and simpler motions',
        config = function ()
        require('leap').create_default_mappings()
        end,
    },
    {'numToStr/Comment.nvim',                                    desc = 'Comments',
        config = function ()
        require('Comment').setup()
        end,
    },
    {'junegunn/fzf', dir = '~/.fzf', build = './install --all',  desc = 'Fuzzy finder core'},
    {'junegunn/fzf.vim',                                         desc = 'Fuzzy finder Vim integration'},
    {'Vimjas/vim-python-pep8-indent',                            desc = 'PEP8-compatible Python indentation'},
    {'nvim-treesitter/nvim-treesitter',                          desc = 'Treesitter integration'},
    {'nvim-treesitter/nvim-treesitter-refactor',                 desc = 'Refactoring with Treesitter'},
    {'hashivim/vim-terraform',                                   desc = 'Terraform integration'},
    {'tsandall/vim-rego',                                        desc = 'Rego highlighting'},
    {'towolf/vim-helm',                                          desc = 'Helm filetype'},
    {'windwp/nvim-spectre',                                      desc = 'Interactive search & replace'},
    {'nvim-lua/plenary.nvim',                                    desc = 'Common dependency for multiple plugins'},
    {'jghauser/mkdir.nvim',                                      desc = 'Automatically create directories'},
    {'nvim-telescope/telescope.nvim', branch = '0.1.x',          desc = 'Fuzzy finder'},
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', desc = 'FZF native integration for Telescope'},
    {'williamboman/mason.nvim',                                  desc = 'Portable package manager for Neovim'},
    {'williamboman/mason-lspconfig.nvim',                        desc = 'Mason and lspconfig integration'},
    {'neovim/nvim-lspconfig',                                    desc = 'LSP integration with built-in LSP'},
    {'peterlundgren/vim-todo',                                   desc = 'Minimalistic To-do filetype'},
    {'MunifTanjim/nui.nvim',                                     desc = 'Dependency for neo-tree'},
    {'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x',             desc = 'File tree'},
    {'hrsh7th/nvim-cmp',                                         desc = 'Completion'},
    {'hrsh7th/cmp-nvim-lsp',                                     desc = 'Completion and LSP integration'},
    {'hrsh7th/cmp-buffer',                                       desc = 'Plugin for nvim-cmp'},
    {'hrsh7th/cmp-cmdline',                                      desc = 'Plugin for nvim-cmp'},
    {'dcampos/nvim-snippy',                                      desc = 'Snippets'},
    {'dcampos/cmp-snippy',                                       desc = 'Completion and Snippets integration'},
    {'tpope/vim-sleuth',                                         desc = 'Set shiftwidth, tabstop, expandtab... automatically'},
    {'darrikonn/vim-gofmt',                                      desc = 'gofmt/goimports on save'},
    { 'folke/neodev.nvim', opts = {},                            desc = 'neovim init.lua and plugin development helper' },
    {'zbirenbaum/copilot.lua',                                   desc = 'Unofficial Github Copilot plugin in Lua',
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                yaml = true,
                markdown = true,
                gitcommit = true,
            },
          })
        end
    },
    {'zbirenbaum/copilot-cmp',                                   desc = 'Copilot completion plugin for zbirenbaum/copilot.lua',
        config = function ()
          require("copilot_cmp").setup()
        end
    },
      {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
          { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
          { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
          -- debug = true, -- Enable debugging
          -- See Configuration section for rest
        },
      },
    {'dstein64/vim-win', desc = "window management" },
    {
        "kylechui/nvim-surround",
        desc = "surround selections",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
})

-- Colorscheme
vim.cmd('colorscheme molokai')
vim.g.molokai_original = 1
vim.g.python_space_error_highlight = 1 -- Python whitespace highlighting.
vim.cmd('set notermguicolors') -- disable 24-bit true colors.

-- Settings
vim.o.cmdheight = 1 -- Bigger display area for command output.
vim.o.showmatch = true -- Show matching brackets for a short moment.
vim.o.mat = 1 -- Blink matching brackets for tenth of a second.
vim.o.laststatus = 2 -- Always display status line.
vim.o.splitbelow = true -- Splitting a window will put it below the current one.
vim.o.splitright = true -- Splitting a window will put it right of the current one.
vim.o.scrolloff = 8 -- Set scroll offset.
-- vim.o.lazyredraw = true -- Screen will not be redrawn unnecessarily.
vim.o.ttimeoutlen = 10 -- Faster switching from insert mode.
vim.o.stal = 1 -- Show tab page labels only if there are at least two tab pages.
vim.o.switchbuf = "useopen,usetab,newtab" -- Change behavior when switching between buffers.
vim.o.showmode = false -- Remove --INSERT-- line from bottom.

-- Convenience
vim.o.hidden = true
vim.o.tabstop = 4 -- Number of spaces that a <Tab> counts for.
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of indentation.
vim.o.expandtab = true -- Spaces are used instead of <Tab>.
vim.o.copyindent = true -- Copy the structure of existing lines indent when autoindenting.
vim.o.wildmenu = true -- Enable enhanced command-line completion.
vim.o.wildignore = "*.swp,*.bak,*.pyc,*.class,*.o,*.obj" -- Ignore these patterns on completion.
vim.o.undolevels = 1000 -- Maximum number of changes that can be undone.
vim.o.history = 100 -- Maximum number of command and search patterns history.
vim.o.autoindent = true -- Copy indent from current line when starting a new line.
vim.o.smartindent = true -- Smart autoindenting when starting a new line.
vim.o.backspace = "indent,eol,start" -- Sane backspace options.
vim.o.encoding = "utf-8" -- Encoding
vim.cmd('set cinkeys-=0#') -- Remove # symbol from reindentation list.
vim.cmd('set indentkeys-=0#') -- Remove # symbol from reindentation list.
vim.o.cinoptions = "l1" -- Change Vim indentation behaviour.
vim.o.formatoptions = vim.o.formatoptions .. "j" -- Delete comment character when joining commented lines.
vim.cmd('set ssop-=options') -- Not saving session-specific options.
vim.o.fillchars = "vert:│,fold:─" -- Splits look prettier.
vim.o.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc"
vim.o.mouse = "a" -- Enable mouse support.
vim.o.modeline = false -- Disable modeline, more convenient and secure.
vim.o.autoread = false -- Don't autoread file changes.
vim.o.belloff = "all" -- Disable bell completely.
vim.o.complete = "w,b,u,t,i" -- Completion behavior.
vim.o.fsync = true -- Every :w is followed by fsync().
vim.o.shortmess = "filnxtToOF" -- Messages to be avoided.
vim.o.showcmd = false -- Don't show command in the last line of the screen.
vim.o.smarttab = false -- Tab always inserts blanks.
vim.o.listchars = "tab:  ,nbsp:·,trail:·,precedes:←,extends:→"
vim.o.list = true -- Show special characters.

-- Search settings
vim.o.incsearch = true -- Highlight where the search pattern matches.
vim.o.hlsearch = true -- Highlight all its matches.
vim.o.ignorecase = true -- Ignore case in search patterns.
vim.o.inccommand = "nosplit" -- In-place preview while substitution.

-- Netrw
vim.g.netrw_banner = 0 -- Hide netrw banner.
vim.g.netrw_liststyle = 3 -- Change netrw browser list style.
vim.g.netrw_browse_split = 4 -- Open on previous window.
vim.g.netrw_winsize = -30
vim.g.netrw_browsex_viewer = 'google-chrome' -- Set preferred browser.

-- Custom command
vim.cmd([[command! Vex exe 'Vexplore' getcwd()]])
vim.cmd([[cnoreabbrev vex Vex]])

-- OS specific configuration
if vim.fn.has('unix') == 1 then
    local uname = vim.fn.system("uname -s")
    if uname == "Darwin\n" then
        -- OS X clipboard support
        if vim.fn.has('clipboard') == 1 then
            vim.cmd('set clipboard^=unnamed')
        end
    elseif uname == "Linux\n" then
        -- Linux clipboard support
        if vim.fn.has('clipboard') == 1 then
            vim.cmd('set clipboard^=unnamedplus')
        end
    end
end

-- Directories
vim.o.undodir = os.getenv("HOME") .. "/.vim/.undo//" -- Persistent undo history directory.
vim.o.backupdir = os.getenv("HOME") .. "/.vim/.backup//" -- Backup directory.
vim.o.directory = os.getenv("HOME") .. "/.vim/.swp//" -- Swap file directory.

-- Create directories if they do not exist
local function mkdir_if_not_exists(dir)
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

mkdir_if_not_exists(vim.o.undodir)
mkdir_if_not_exists(vim.o.backupdir)
mkdir_if_not_exists(vim.o.directory)

-- Enable undo, backup, and swap files.
vim.o.undofile = true
vim.o.backup = true
vim.o.swapfile = true

-- '_' character will not be regarded as part of a word.
vim.cmd('set iskeyword-=_')

-- Show visual cues for wrapped lines.
vim.o.breakindent = true
vim.o.showbreak = '↳'

-- Global shortcuts
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true})
vim.api.nvim_set_keymap('n', 'X', '"_x', {noremap = true})
vim.api.nvim_set_keymap('n', 'XX', '"_dd', {noremap = true})

-- Map uppercase WQ and the like to lowercase ones.
vim.cmd('command W w')
vim.cmd('command WQ wq')
vim.cmd('command Wq wq')
vim.cmd('command Q q')

-- Make Y copy from cursor to the end of the line
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})

-- Keep search matches in the middle of the screen
vim.api.nvim_set_keymap('n', 'n', 'nzz', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', {noremap = true})

-- Scratch buffer
vim.cmd('command! Scratch vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile')

if vim.fn.executable('ag') == 1 then
    vim.g.ackprg = 'ag --vimgrep --hidden'
end

-- LSP integration
     local on_attach = function(client, bufnr)
       vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.diagnostic.open_float({focusable = false})')
     end

     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
       vim.lsp.diagnostic.on_publish_diagnostics, {
         virtual_text = false,
         update_in_insert = false
       }
     )

    -- nvim-cmp extra capabilities. Depends on nvim-cmp.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {"gopls", "yamlls", "terraformls", "pylsp"}
    })

    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
                on_attach=on_attach,
                capabilities=capabilities,
            }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["pylsp"] = function ()
            require("lspconfig").pylsp.setup{
                on_attach=on_attach,
                capabilities=capabilities,
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
                capabilities=capabilities,
                settings = {
                    yaml = {
                        schemas = { kubernetes = {"*.yml", "*.yaml"} }
                    }
                }
            }
        end,
        ["gopls"] = function ()
            require("lspconfig").gopls.setup{
                on_attach=on_attach,
                capabilities=capabilities,
            }
        end,
        ["terraformls"] = function ()
            require("lspconfig").terraformls.setup{
                on_attach=on_attach,
                capabilities=capabilities,
                filetypes = { "terraform","hcl" }
            }
        end,


    }

-- Completion (nvim-cmp)
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      require 'snippy'.expand_snippet(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'snippy' },
    { name = 'buffer' },
  },
}

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
END


set signcolumn=yes  " Always show sign column, prevents it from flashing when linter updates
set updatetime=100  " Faster updates for hover/linter

" LSP bindings
nnoremap <silent> <Leader>ge    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>h    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <Leader>gi    <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> <Leader>go    <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> <Leader>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>gn    <cmd>lua vim.lsp.buf.rename()<CR>

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
      ensure_installed = "all",
      ignore_install = { "phpdoc" },

      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {"python"}
      },
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

" Neotree configuration
nnoremap <silent> <Leader>n :Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>
let g:neo_tree_remove_legacy_commands = 1
:lua << END
require("neo-tree").setup({
  sources = {
      "filesystem",
  },
  filesystem = {
    filtered_items = {
       visible = true,
       hide_dotfiles = false,
       hide_gitignored = false,
       hide_hidden = false,
    },
    window = {
      mappings = {
        -- disable deletion
        ["d"] = "noop",
      }
    },
  },
  default_component_configs = {
    icon = {
      folder_closed = "/",
      folder_open = "/",
      folder_empty = "/",
      folder_empty_open = "/.",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
        deleted   = "✖",
        modified  = "Ⓜ",
        renamed   = "R",
        -- Status type
        untracked = "?",
        ignored   = "I",
        unstaged  = "…",
        staged    = "",
        conflict  = "♺",
      },
      align = "right",
    },
   }
})

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
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        },
  }
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

require('telescope').load_extension('fzf')
END

nnoremap <Leader>F :Telescope find_files cwd=%:p:h<CR>

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


" BIND <Leader> + w to remove trailing whitespaces.
nnoremap <Leader>W :%s/\s\+$//e<CR>

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
    " if exists(':GoBuild')
    "     nnoremap <silent> <Leader>ge :GoIfErr<CR>
    "     nnoremap <silent> <Leader>gr :GoImports<CR>
    " endif
endfunction

au VimEnter * call SetPluginBindings()

" Command to invoke nvim-spectre
command! Spectre :lua require('spectre').open()

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

" Autocompletion
set completeopt=menu,menuone,noinsert,noselect

" Neosnippets
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#snippets_directory = '~/.vim/mysnippets'

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
  return winwidth(0) > 90 ? FugitiveHead()[0:10] : ''
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

" newer versions of vim-fugitive broke Gblame, restore it back
command! Gblame :Git blame

" vim-todo
" Associate To-do files for vim-todo
au BufRead,BufNewFile TODO set filetype=todo
" Shortcut for adding new task
nnoremap <silent> <Leader>tn o[ ] 
