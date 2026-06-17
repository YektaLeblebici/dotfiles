" VIMRC - Yekta Leblebici <yekta@iamyekta.com>
" depends: neovim (>=v0.11.0), ag (>= 2.2.0), rg (>=13.0.0)

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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy").setup({
    {'flazz/vim-colorschemes',                                   desc = 'Colorschemes'},
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'powerline',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = false,
            globalstatus = false,
            refresh = {
              statusline = 100,
              tabline = 100,
              winbar = 100,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
        tabline = {
            lualine_a = {{'tabs', mode=1, use_mode_colors = true, max_length = vim.o.columns}},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
        end,
    },
    {'tpope/vim-fugitive',                                       desc = 'Git integration'},
    {'mbbill/undotree',                                          desc = 'Undo tree visualizer'},
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      },
    },
    {'junegunn/fzf', build = './install --all',                  desc = 'Fuzzy finder core'},
    {'junegunn/fzf.vim',                                         desc = 'Fuzzy finder Vim integration'},
    {'Vimjas/vim-python-pep8-indent',                            desc = 'PEP8-compatible Python indentation'},
    {'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate', desc = 'Treesitter integration'},
    {'hashivim/vim-terraform',                                   desc = 'Terraform integration'},
    {'towolf/vim-helm',                                          desc = 'Helm filetype'},
    {'windwp/nvim-spectre',                                      desc = 'Interactive search & replace'},
    {'nvim-lua/plenary.nvim',                                    desc = 'Common dependency for multiple plugins'},
    {'jghauser/mkdir.nvim',                                      desc = 'Automatically create directories'},
    {'nvim-telescope/telescope.nvim', branch = '0.1.x',          desc = 'Fuzzy finder'},
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', desc = 'FZF native integration for Telescope'},
    {'mason-org/mason.nvim',                                     desc = 'Portable package manager for Neovim'},
    {'mason-org/mason-lspconfig.nvim',                           desc = 'Mason and lspconfig integration'},
    {'neovim/nvim-lspconfig',                                    desc = 'LSP integration with built-in LSP'},
    {'peterlundgren/vim-todo',                                   desc = 'Minimalistic To-do filetype'},
    {
        'saghen/blink.cmp',
        version = '*', -- release tag: pulls the prebuilt fuzzy-matching binary (no cargo needed)
        desc = 'Completion engine (replaces nvim-cmp + cmp-* + snippy + copilot-cmp)',
        dependencies = {
            'rafamadriz/friendly-snippets',
            { 'fang2hou/blink-copilot', dependencies = { 'zbirenbaum/copilot.lua' } },
        },
        config = function()
            require('blink.cmp').setup({
                -- 'enter' preset: <CR> accepts, <C-space> opens menu/docs, <C-e> hides,
                -- <C-b>/<C-f> scroll docs, <Tab>/<S-Tab> jump snippet stops.
                keymap = { preset = 'enter' },
                sources = {
                    default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
                    providers = {
                        copilot = {
                            name = 'copilot',
                            module = 'blink-copilot',
                            score_offset = 100,
                            async = true,
                            opts = { max_completions = 5 }, -- default 3; surface more Copilot items
                        },
                    },
                },
                snippets = { preset = 'default' }, -- native vim.snippet + friendly-snippets
                signature = { enabled = true }, -- show LSP signature help while typing arguments
                cmdline = {
                    keymap = { preset = 'cmdline' },
                    completion = { menu = { auto_show = true } },
                },
            })
        end,
    },
    {'stevearc/conform.nvim',                                    desc = 'Formatters and prettifiers',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    go = { "gofmt" },
                    terraform = { "terraform_fmt" },
                },
                format_on_save = {
                  -- These options will be passed to conform.format()
                  timeout_ms = 500,
                  lsp_format = "fallback",
                },
            })
        end
    },
    {'tpope/vim-sleuth',                                         desc = 'Set shiftwidth, tabstop, expandtab... automatically'},
    { 'folke/lazydev.nvim', ft = 'lua', opts = {},               desc = 'Lua LS for Neovim config & plugin development (replaces neodev)' },
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
      {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
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
    },
    {'someone-stole-my-name/yaml-companion.nvim',                desc = 'YAML Schema helper',
        config = function()
            require("telescope").load_extension("yaml_schema")
        end
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "classic",
                -- Customize highlight groups for colors
                -- Use Neovim highlight group names or hex colors like "#RRGGBB"
                hi = {
                    error = "DiagnosticError",     -- Highlight for error diagnostics
                    warn = "DiagnosticWarn",       -- Highlight for warning diagnostics
                    info = "DiagnosticInfo",       -- Highlight for info diagnostics
                    hint = "DiagnosticHint",       -- Highlight for hint diagnostics
                    arrow = "NonText",             -- Highlight for the arrow pointing to diagnostic
                    background = "CursorLine",     -- Background highlight for diagnostics
                    mixing_color = "Normal",       -- Color to blend background with (or "None")
                },
                options = {
                    multilines = {
                        enabled = false,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics

        end,
    },
    { 'nvim-mini/mini.nvim', version = false,
        config = function()
            require('mini.files').setup({
              -- General options
              options = {
                -- Whether to delete permanently or move into module-specific trash
                permanent_delete = false,
                -- Whether to use for editing directories
                use_as_default_explorer = true,
              },

              windows = {
                -- Whether to show preview of file/directory under cursor
                preview = true,
              },
            })
            vim.keymap.set("n", "<leader>t", function()
              if MiniFiles.get_explorer_state() then
                MiniFiles.close()
              else
                MiniFiles.open()
              end
            end, { desc = "Toggle mini.files" })
        end
    },

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

-- OS-specific clipboard. Uses libuv (vim.uv) instead of shelling out to `uname`.
if vim.fn.has('clipboard') == 1 then
    local sysname = vim.uv.os_uname().sysname
    if sysname == "Darwin" then
        vim.opt.clipboard:prepend("unnamed")      -- macOS
    elseif sysname == "Linux" then
        vim.opt.clipboard:prepend("unnamedplus")  -- Linux
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
vim.cmd('command! W w')
vim.cmd('command! WQ wq')
vim.cmd('command! Wq wq')
vim.cmd('command! Q q')

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

    -- Diagnostics behaviour. Replaces the removed
    -- vim.lsp.diagnostic.on_publish_diagnostics handler. virtual_text stays off
    -- here (tiny-inline-diagnostic renders diagnostics inline); signs use the
    -- Neovim defaults.
    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = false,
    })

    -- LSP client capabilities, augmented by blink.cmp.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    require("mason").setup()
    -- mason-lspconfig 2.x removed the `handlers` API; we disable automatic_enable
    -- and configure + enable servers ourselves via the native vim.lsp.config /
    -- vim.lsp.enable API (Neovim 0.11+), which replaces the deprecated
    -- require('lspconfig').<server>.setup framework. Per-server defaults (cmd,
    -- filetypes, root markers) still come from nvim-lspconfig's lsp/ directory.
    require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "yamlls", "terraformls", "pylsp" },
        automatic_enable = false,
    })

    -- Apply completion capabilities to every server.
    vim.lsp.config('*', { capabilities = capabilities })

    -- gopls needs no overrides beyond the global capabilities.

    vim.lsp.config('pylsp', {
        settings = {
            pylsp = {
                plugins = {
                    preload = { enabled = true },
                    pylint = { enabled = true },
                    rope_completion = { enabled = true },
                    yapf = { enabled = true },
                    autopep8 = { enabled = false }, -- yapf is the sole formatter
                }
            }
        }
    })

    vim.lsp.config('terraformls', {
        filetypes = { "terraform", "hcl" },
    })

    -- yamlls is configured via yaml-companion, whose setup() returns a client
    -- config table (on_attach/on_init/handlers/settings) that vim.lsp.config accepts.
    vim.lsp.config('yamlls', require("yaml-companion").setup({
        builtin_matchers = {
            kubernetes = { enabled = true },
            cloud_init = { enabled = false }
        },
        lspconfig = {
            capabilities = capabilities,
        },
    }))

    vim.lsp.enable({ "gopls", "yamlls", "terraformls", "pylsp" })


-- Completion is handled by blink.cmp, configured in its plugin spec above.
END


set signcolumn=yes  " Always show sign column, prevents it from flashing when linter updates
set updatetime=100  " Faster updates for hover/linter

" LSP bindings
nnoremap <silent> <Leader>ge    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>h     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>gf    <cmd>lua vim.lsp.buf.format()<CR>
nnoremap <silent> <Leader>gi    <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> <Leader>go    <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> <Leader>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>gu    <cmd>lua vim.lsp.buf.code_action()<CR>


" Treesitter configuration
:lua << END
    local ts = require('nvim-treesitter')
    ts.setup()

    local ignore = { phpdoc = true, ipkg = true, org = true, gitcommit = true }

    -- Install parsers on demand, one per filetype.
    local available = {}
    for _, l in ipairs(ts.get_available()) do available[l] = true end
    local installed = {}
    for _, l in ipairs(ts.get_installed()) do installed[l] = true end

    local function enable(buf, ft, lang)
      pcall(vim.treesitter.start, buf, lang)
      if ft ~= 'python' then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang or ignore[lang] or not available[lang] then return end

        if installed[lang] then
          enable(buf, ft, lang)
        else
          installed[lang] = true  -- mark first to avoid re-triggering installs
          ts.install(lang):await(function(err)
            if err then installed[lang] = nil return end
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(buf) then enable(buf, ft, lang) end
            end)
          end)
        end
      end,
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
function! SetLeaderBackspace()
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

" terraform
let g:terraform_fmt_on_save=1

" newer versions of vim-fugitive broke Gblame, restore it back
command! Gblame :Git blame

" vim-todo
" Associate To-do files for vim-todo
au BufRead,BufNewFile TODO set filetype=todo
" Shortcut for adding new task
nnoremap <silent> <Leader>tn o[ ] 
