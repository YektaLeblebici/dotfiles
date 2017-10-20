# Dotfiles

Some of my configuration files and resources I use everyday. I do my best to keep them readable and useful to everyone.

## vimrc
![Screenshot](screenshots/vim1.png?raw=true "Screenshot")

Cherry-picked plugins, bunch of customizations and (hopefully) not-too-invasive keybindings. Make sure you've read it first before applying.

**Depends:** vim (>=8) (+python +clipboard), vimplug, exuberant-ctags, silversearcher-ag (>= 0.29.1)

## zshrc

Awesome command prompt I always wanted, using oh-my-zsh. 
It has autocompletion, fuzzy finder, fasd (frecent file finder), Powerlevel9k theme and minor improvements.

### How to setup
* sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
* git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
* brew install ag
* git clone https://github.com/junegunn/fzf.git $ZSH_CUSTOM/plugins/fzf 
* $ZSH_CUSTOM/plugins/fzf/install --bin 
* git clone https://github.com/Treri/fzf-zsh.git $ZSH_CUSTOM/plugins/fzf-zsh 
* git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
* git clone https://github.com/changyuheng/zsh-interactive-cd $ZSH_CUSTOM/plugins/zsh-interactive-cd
* brew install fasd

**Depends:** oh-my-zsh, powerlevel9k, fasd, fzf, fzf-zsh, silversearcher-ag, zsh-autosuggestions

## tmux.conf
* Better defaults (in my opinion), such as CTRL+a as prefix, faster key repetition, numbering from 0, Alt key switching between panes etc.
* Vim copy, works with OS X.
* CTRL+M for toggling mouse mode.
* Capture pane and open in Vim.
* A very nice theme I got from somewhere, cannot recall its source though.

## defaults.sh
My OS X settings and tweaks as a shell script.

## Brewfile

CLI stuff and Casks I use on OS X.  
I do my best to install all my GUI applications with "brew cask".
