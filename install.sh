#!/bin/sh
# Quick and dirty shell script to act as a playbook
set -eu

cd "$(dirname "$0")"
DOTFILES_DIR="$(pwd)"

METHOD="${1:-}"

# Pairs of "src:dst-relative-to-$HOME", one per line. Blank lines ignored.
SYMLINKS_COMMON='
zshrc:.zshrc
vimrc:.vimrc
tmux.conf:.tmux.conf
p10k.zsh:.p10k.zsh
zsh_plugins.txt:.zsh_plugins.txt
atuin:.config/atuin
init.vim:.config/nvim/init.vim
mysnippets:.vim/mysnippets
cheat:.cheat
jrnl_config:.config/jrnl/jrnl_config
claude/statusline.sh:.claude/statusline.sh
'

SYMLINKS_OSX='
kitty.conf:.config/kitty/kitty.conf
pypoetry/config.toml:Library/Application Support/pypoetry/config.toml
gitconfig.work:.gitconfig
'

SYMLINKS_LINUX_HEADLESS='
pypoetry/config.toml:.config/pypoetry/config.toml
gitconfig:.gitconfig
'

usage() {
    echo "Usage: $0 <method>"
    echo "  Methods:"
    echo "    osx             Full macOS setup (defaults, kitty, Brewfile, gcloud, krew)"
    echo "    linux_headless  Linuxbrew-based setup using Brewfile.linux_headless"
    exit 1
}

require_host() {
    expected="$1"
    case "$(uname -s)" in
        Darwin) detected=osx ;;
        Linux)  detected=linux_headless ;;
        *)      echo "Unsupported platform: $(uname -s)" >&2; exit 1 ;;
    esac
    if [ "$detected" != "$expected" ]; then
        echo "Method '$expected' selected, but this host looks like '$detected'." >&2
        echo "Re-run with '$0 $detected' or run on the matching platform." >&2
        exit 1
    fi
}

preflight() {
    # Verify required files exist before any side effects.
    for path in "$@"; do
        if [ ! -e "$DOTFILES_DIR/$path" ]; then
            echo "Preflight failed: missing $DOTFILES_DIR/$path" >&2
            exit 1
        fi
    done
}

ensure_brew() {
    if command -v brew >/dev/null 2>&1; then
        echo "Homebrew already installed"
        return
    fi
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
}

link_each() {
    # Idempotent symlink with backup. Reads "src:dst-relative-to-$HOME"
    # pairs from stdin.
    while IFS=: read -r src rel; do
        [ -z "$src" ] && continue
        srcpath="$DOTFILES_DIR/$src"
        dst="$HOME/$rel"
        mkdir -p "$(dirname "$dst")"
        if [ -e "$dst" ] && [ ! -L "$dst" ]; then
            echo "  backup: $dst -> $dst.bak"
            mv "$dst" "$dst.bak"
        fi
        ln -sfn "$srcpath" "$dst"
        echo "  linked: $rel"
    done
}

verify_each() {
    fail=0
    while IFS=: read -r src rel; do
        [ -z "$src" ] && continue
        dst="$HOME/$rel"
        if [ -L "$dst" ] && [ -e "$dst" ]; then
            echo "  OK   $rel"
        else
            echo "  FAIL $rel" >&2
            fail=1
        fi
    done
    return $fail
}

clone_tpm() {
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "  tpm already cloned"
    else
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
}

verify_tpm() {
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "  OK   .tmux/plugins/tpm"
    else
        echo "  FAIL .tmux/plugins/tpm" >&2
        return 1
    fi
}

install_osx() {
    require_host osx
    preflight defaults.sh Brewfile gitconfig.work pypoetry/config.toml kitty.conf

    echo "Running defaults"
    ./defaults.sh

    ensure_brew

    echo "Installing git"
    brew install git

    echo "Linking dotfiles"
    printf '%s\n%s\n' "$SYMLINKS_COMMON" "$SYMLINKS_OSX" | link_each

    echo "Cloning tmux plugin manager"
    clone_tpm

    echo "Running brew to install the bundle"
    brew bundle

    echo "Running pipx"
    ./pipx_install.sh
    echo "Running npm.sh"
    ./npm.sh
    echo "Running gcloud.sh"
    ./gcloud.sh
    echo "Running goinstall.sh"
    ./goinstall.sh

    echo "Installing kubectl plugins"
    kubectl krew install kyverno || true
    kubectl krew install explore || true

    echo "Installing gcloud components"
    gcloud components install gke-gcloud-auth-plugin || true

    echo "Verifying symlinks"
    printf '%s\n%s\n' "$SYMLINKS_COMMON" "$SYMLINKS_OSX" | verify_each
    verify_tpm

    echo
    echo "Don't forget to:"
    echo "  - Install uBlock Origin on Google Chrome"
    echo "  - Select \"Continue where you left off\" and \"Show bookmarks bar\" in chrome://settings/"
}

install_linux_headless() {
    require_host linux_headless
    preflight Brewfile.linux_headless gitconfig pypoetry/config.toml

    ensure_brew

    echo "Installing git"
    brew install git

    echo "Linking dotfiles"
    printf '%s\n%s\n' "$SYMLINKS_COMMON" "$SYMLINKS_LINUX_HEADLESS" | link_each

    echo "Cloning tmux plugin manager"
    clone_tpm

    echo "Running brew to install the linux_headless bundle"
    brew bundle --file=Brewfile.linux_headless

    # gcloud-cli cask installs binaries under share/, not bin/, on Linuxbrew.
    export PATH="$(brew --prefix)/share/google-cloud-sdk/bin:$PATH"

    echo "Running pipx"
    ./pipx_install.sh
    echo "Running npm.sh"
    ./npm.sh
    echo "Running gcloud.sh"
    ./gcloud.sh
    echo "Running goinstall.sh"
    ./goinstall.sh

    echo "Installing kubectl plugins"
    kubectl krew install kyverno || true
    kubectl krew install explore || true

    echo "Verifying symlinks"
    printf '%s\n%s\n' "$SYMLINKS_COMMON" "$SYMLINKS_LINUX_HEADLESS" | verify_each
    verify_tpm
}

case "$METHOD" in
    osx)            install_osx ;;
    linux_headless) install_linux_headless ;;
    *)              usage ;;
esac
