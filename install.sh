#!/bin/sh
# Quick and dirty shell script to act as a playbook
PWD=$(pwd)


echo "Running defaults"
./defaults.sh

echo "Installing git"
brew install git

echo "Setting up kitty"
mkdir -p $HOME/.config/kitty
ln -s $PWD/kitty.conf $HOME/.config/kitty/kitty.conf

echo "Setting up zshrc"
rm $HOME/.zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc

echo "Setting up CLI tool configurations"
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/p10k.zsh $HOME/.p10k.zsh
ln -s $(pwd)/zsh_plugins.txt $HOME/.zsh_plugins.txt
ln -s $(pwd)/atuin $HOME/.config/atuin

echo "Setting up pypoetry"
mkdir -p $HOME/Library/Application\ Support/pypoetry
ln -s $(pwd)/pypoetry/config.toml $HOME/Library/Application\ Support/pypoetry/config.toml

echo "Setting up nvim"
mkdir -p $HOME/.config/nvim
ln -s $(pwd)/init.vim $HOME/.config/nvim/init.vim
mkdir -p $HOME/.vim
ln -s $PWD/mysnippets $HOME/.vim/mysnippets

echo "Setting up cheat"
ln -s $PWD/cheat $HOME/.cheat

echo "Setting up .gitconfig"
ln -s $PWD/gitconfig.work $HOME/.gitconfig

echo "Setting up jrnl"
mkdir -p $HOME/.config/jrnl
ln -s $PWD/jrnl_config $HOME/.config/jrnl/


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
kubectl krew install kyverno
kubectl krew install explore

echo "Installing gcloud components"
gcloud components install gke-gcloud-auth-plugin


# Don't forget to:
# - Install uBlock Origin on Google Chrome
# - Select "Continue where you left off" and "Show bookmarks bar" in chrome://settings/
