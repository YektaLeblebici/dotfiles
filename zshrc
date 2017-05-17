# .zshrc
# - Yekta Leblebici <yekta@iamyekta.com>
# Depends: oh-my-zsh, powerline, fasd, fzf, fzf-zsh, zsh-autosuggestions
#
# Get dependencies by running:
#  apt-get install powerline
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" (Not a great way to do this.)
#  git clone https://github.com/junegunn/fzf.git $ZSH_CUSTOM/plugins/fzf 
#  $ZSH_CUSTOM/plugins/fzf/install --bin
#  git clone https://github.com/Treri/fzf-zsh.git $ZSH_CUSTOM/plugins/fzf-zsh
#  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#  git clone https://github.com/changyuheng/zsh-interactive-cd $ZSH_CUSTOM/plugins/zsh-interactive-cd
#  Get fasd from: https://github.com/clvv/fasd and simply run "make install"
#  apt-get install silversearcher-ag (preferably from "testing", package in "jessie" is quite old)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/aranel/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# NOTE: This is not being used as its overriden by Powerline.

# I use powerline, not a ZSH_THEME anyway.
ZSH_THEME="robbyrussell"

# Disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ZSH_CUSTOM=/path/to/new-custom-folder

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#
plugins=(git \
         fasd \
         colored-man-pages \
         extract \
         vagrant \
         docker \
         fzf-zsh \
         ssh-agent \
         zsh-autosuggestions \
         zsh-interactive-cd \
         catimg \
         copybuffer \
         fancy-ctrl-z)

source $ZSH/oh-my-zsh.sh

## Completion tweaks
zstyle ':completion:*' use-ip true

# Completion for parent directory.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Add your identity files below to have them automatically added.
zstyle :omz:plugins:ssh-agent identities id_rsa id_work_rsa
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Blue colorscheme for FZF. I may use that in the future.
# export FZF_DEFAULT_OPTS='--color dark,hl:33,fg+:254,hl+:37 --color info:254,prompt:37,spinner:108,pointer:235,marker:235'

# Use ag as the default source.
# Depends on installed "ag", comment out these two if not.
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" 

# Consistent ordering between CTRL+R history search and CTRL+T.
export FZF_CTRL_R_OPTS="--reverse"

# Dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'                                                
fi

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"

# GCC Colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Powerline
if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    source /usr/share/powerline/bindings/zsh/powerline.zsh
fi

# Golang
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.go/bin
export GOPATH=$HOME/.go

# Local binaries (=pip install --user)
export PATH=$PATH:$HOME/.local/bin

# Styling
export TERM=xterm-256color
export GREP_OPTIONS="--color"

# Editor
export EDITOR='vim'

# Homebrew
HOMEBREW_NO_ANALYTICS=1
export PATH="$HOME/.linuxbrew/bin:$PATH"

# Turns out I am not a cow person.
export ANSIBLE_NOCOWS=1

# Helps you win your sanity back... Depends: fortune, lolcat, cowsay
alias insane="fortune | cowsay -f $(ls /usr/share/cowsay/cows/|shuf -n 1) | lolcat"
# Disabling v (fasd), replaced it with a new v command. (fzf+fasd)
# alias v="f -e vim -b viminfo"

### FZF Commands
# Disable all these if you don't want to use FZF.
# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fag - ag search with FZF
alias fag="ag --nobreak --nonumbers --noheading . | fzf"

# flog - git log with FZF
flog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcs - FZF command to get commit sha, useful combined with git commands.
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fdif - FZF command to get diff between two commits, interactively. 
# Requires fcs() function uncommented to work.
fdif(){
 git diff `fcs` `fcs`
}

# fv - FZF + fasd to edit recent vim files faster.
# Don't change this fv() to v(), or all hell may break loose.
fv(){
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}
alias v="fv"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
