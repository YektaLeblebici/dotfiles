#!/bin/sh
# Quick and dirty shell script to act as a playbook
PWD=$(pwd)

./defaults.sh

brew install git
brew install svn

mkdir -p $HOME/.config/kitty
ln -s $PWD/kitty.conf $HOME/.config/kitty/kitty.conf

ln -s $PWD/karabiner.json /Users/yekta/.config/karabiner/karabiner.json

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm $HOME/.zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc

ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/p10k.zsh $HOME/.p10k.zsh

mkdir -p $HOME/.config/nvim
ln -s $(pwd)/init.vim $HOME/.config/nvim/init.vim

ln -s $PWD/cheat $HOME/.cheat

ln -s $PWD/gitconfig.work $HOME/.gitconfig

mkdir -p $HOME/.config/jrnl
ln -s $PWD/jrnl_config $HOME/.config/jrnl/

ln -s $PWD/mysnippets $HOME/.vim

# brew bundle


ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/junegunn/fzf.git $ZSH_CUSTOM/plugins/fzf
$ZSH_CUSTOM/plugins/fzf/install --bin
git clone https://github.com/Treri/fzf-zsh.git $ZSH_CUSTOM/plugins/fzf-zsh
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/changyuheng/zsh-interactive-cd $ZSH_CUSTOM/plugins/zsh-interactive-cd

pip3 install -r requirements.txt

./npm.sh
./gcloud.sh


# Don't forget to:
# - Install uBlock Origin on Google Chrome
# - Select "Continue where you left off" and "Show bookmarks bar" in chrome://settings/


