
# Dotfiles

Some of my configuration files and resources I use everyday. I do my best to keep them readable and useful to everyone.

### vimrc
![Screenshot](screenshots/vim1.png?raw=true "Screenshot")

Cherry-picked plugins, bunch of customizations and (hopefully) not-too-invasive keybindings. Make sure you've read it first before applying.

**Depends:** vim (>=8) (+python), vimplug, exuberant-ctags, silversearcher-ag (>= 0.29.1)

### bashrc

Nothing really fancy. Just sane defaults, Powerline and Fasd integration.
To make powerline and fasd play nice together, I've made a small change, simply run:
> cp powerline.sh /usr/share/powerline/bindings/bash/powerline.sh

**Depends:** powerline, fasd
