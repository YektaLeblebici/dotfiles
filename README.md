
# Dotfiles

Some of my configuration files and resources I use everyday. I do my best to keep them readable and useful to everyone.

### vimrc
![Screenshot](screenshots/vim1.png?raw=true "Screenshot")

Cherry-picked plugins, bunch of customizations and (hopefully) not-too-invasive keybindings. Make sure you've read it first before applying.

**Depends:** vim (>=8) (+python), vimplug, exuberant-ctags, silversearcher-ag (>= 0.29.1)

### i3lock-fancy-multimonitor
![Screenshot](screenshots/i3lock1.png?raw=true "Screenshot")

Original script taken from https://github.com/guimeira/i3lock-fancy-multimonitor

* I've changed it to pixelate the screen instead of blurring.
* It now shows failed attempts. (i3lock -f)

**Depends:** i3lock, scrot, imagemagick

### zshrc

Awesome command prompt as I always wanted, using oh-my-zsh. 
It has autocompletion, fuzzy finder, fasd (frecent file finder), Powerline integration and minor improvements.

##### How to setup
* apt-get install powerline 
* sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
* git clone https://github.com/junegunn/fzf.git $ZSH_CUSTOM/plugins/fzf 
* $ZSH_CUSTOM/plugins/fzf/install --bin 
* git clone https://github.com/Treri/fzf-zsh.git $ZSH_CUSTOM/plugins/fzf-zsh 
* git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 

After running those, get "fasd" from: https://github.com/clvv/fasd and simply run "make install".

**Depends:** oh-my-zsh, powerline, fasd, fzf, fzf-zsh, zsh-autosuggestions

### bashrc

Nothing really fancy. Just sane defaults, Powerline and Fasd integration.
To make powerline and fasd play nice together, I've made a small change, simply run:
> cp powerline.sh /usr/share/powerline/bindings/bash/powerline.sh

**Depends:** powerline, fasd
