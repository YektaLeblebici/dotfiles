# Dotfiles

Some of my configuration files and the resources I use every day. I do my best
to keep them readable and useful to everyone.

## Install

`install.sh` is the entry point. Pick the method that matches the machine:

```sh
./install.sh osx             # full macOS setup
./install.sh linux_headless  # Linuxbrew-based setup, no GUI
```

It installs Homebrew if missing, symlinks the dotfiles into `$HOME`, installs
the Brewfile, and runs the per-ecosystem helpers (`pipx_install.sh`, `npm.sh`,
`goinstall.sh`, `gcloud.sh`). The method must match the host — running `osx` on
Linux (or vice versa) exits early with an error.

## What's here

### vimrc
Cherry-picked plugins, a bunch of customizations, and (hopefully)
not-too-invasive keybindings. Treesitter, LSP via `nvim-lspconfig`/`mason`,
Telescope, and completion with `nvim-cmp`. Read it before applying.

### zshrc
The command prompt I always wanted: [antidote](https://antidote.sh) for plugin
management, the Powerlevel10k theme, `fzf` fuzzy finding, `atuin` history, and
`mise` for runtime versions. Homebrew paths are resolved per-platform.

### tmux.conf
Better defaults (in my opinion): `CTRL+a` prefix, faster key repetition, panes
numbered from 1, vi copy-mode, mouse-mode toggle, and pane capture into Vim.
Uses [tpm](https://github.com/tmux-plugins/tpm) for plugins.

### Brewfile / Brewfile.linux
`Brewfile` is the full macOS list (CLI tools and casks). `Brewfile.linux_headless` is
a curated, formula-first subset for headless Linux installs — casks that don't
work on Linuxbrew are omitted.

### defaults.sh
macOS settings and tweaks as a shell script (Dock, Finder, keyboard, etc.).

### cheat/
Personal cheatsheets for [`cheat`](https://github.com/cheat/cheat).

### claude/
Single-line [Claude Code](https://claude.com/claude-code) status line, symlinked
to `~/.claude/statusline.sh`.
