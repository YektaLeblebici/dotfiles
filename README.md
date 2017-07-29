# Dotfiles

Some of my configuration files and resources I use everyday. I do my best to keep them readable and useful to everyone.

### vimrc
![Screenshot](screenshots/vim1.png?raw=true "Screenshot")

Cherry-picked plugins, bunch of customizations and (hopefully) not-too-invasive keybindings. Make sure you've read it first before applying.

**Depends:** vim (>=8) (+python +clipboard), vimplug, exuberant-ctags, silversearcher-ag (>= 0.29.1)

### zshrc

Awesome command prompt I always wanted, using oh-my-zsh. 
It has autocompletion, fuzzy finder, fasd (frecent file finder), Powerlevel9k theme and minor improvements.

##### How to setup
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

### i3lock-fancy-multimonitor
![Screenshot](screenshots/i3lock1.png?raw=true "Screenshot")

Original script taken from https://github.com/guimeira/i3lock-fancy-multimonitor

* I've changed it to pixelate the screen instead of blurring.
* It now shows failed attempts. (i3lock -f)

**Depends:** i3lock, scrot, imagemagick

### Xresources

Xresources file to be used with rxvt-unicode-256color terminal. 

Uses "Hack" font with "Molokai" color theme, with sane behaviour, font rendering and styling configurations. Also uses "vtwheel" extension to improve scroll wheel behavior. 

##### How to setup
* Get vtwheel extension source from https://aur.archlinux.org/packages/urxvt-vtwheel/ and copy it to ~/.rxvt-ext directory. 
* Get Hack font from https://github.com/chrissimpkins/Hack and place it under ~/.fonts directory.   
* Make sure you run "xrdb .Xresources" after making any changes to this file.

**Depends**: vtwheel, Hack font

### bashrc

Nothing really fancy. Just sane defaults, Powerline and Fasd integration.
To make powerline and fasd play nice together, I've made a small change, simply run:
> cp powerline.sh /usr/share/powerline/bindings/bash/powerline.sh

**Depends:** powerline, fasd

### thinkfan.conf

Thinkfan profile for my Thinkpad T420. Prioritizes less noise over overall heat.

**Depends:** thinkfan
