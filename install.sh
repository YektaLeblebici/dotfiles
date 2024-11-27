#!/bin/sh
# Quick and dirty shell script to act as a playbook
PWD=$(pwd)

./defaults.sh

brew install git
brew install svn

mkdir -p $HOME/.config/kitty
ln -s $PWD/kitty.conf $HOME/.config/kitty/kitty.conf

ln -s $PWD/karabiner.json /Users/yekta/.config/karabiner/karabiner.json

rm $HOME/.zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc

ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/p10k.zsh $HOME/.p10k.zsh
ln -s $(pwd)/zsh_plugins.txt $HOME/.zsh_plugins.txt

mkdir -p $HOME/.config/nvim
ln -s $(pwd)/init.vim $HOME/.config/nvim/init.vim

ln -s $PWD/cheat $HOME/.cheat

ln -s $PWD/gitconfig.work $HOME/.gitconfig

mkdir -p $HOME/.config/jrnl
ln -s $PWD/jrnl_config $HOME/.config/jrnl/

ln -s $PWD/mysnippets $HOME/.vim

# brew bundle

pip3 install -r requirements.txt

./npm.sh
./gcloud.sh
./goinstall.sh

# Don't forget to:
# - Install uBlock Origin on Google Chrome
# - Select "Continue where you left off" and "Show bookmarks bar" in chrome://settings/