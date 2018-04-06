# .zshrc
# - Yekta Leblebici <yekta@iamyekta.com>
# Depends: oh-my-zsh, powerlevel9k, fasd, fzf, fzf-zsh, zsh-autosuggestions
#
# Get dependencies by running:
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" (Not a great way to do this.)
#  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
#  git clone https://github.com/junegunn/fzf.git $ZSH_CUSTOM/plugins/fzf 
#  $ZSH_CUSTOM/plugins/fzf/install --bin
#  git clone https://github.com/Treri/fzf-zsh.git $ZSH_CUSTOM/plugins/fzf-zsh
#  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#  git clone https://github.com/changyuheng/zsh-interactive-cd $ZSH_CUSTOM/plugins/zsh-interactive-cd
#  brew install fasd 
#  brew install ag

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# 256-color support
# Setting this here appears to be not a great idea and hinders tmux support.
# Anyway, comment it out if your terminal app is crap.
# export TERM=xterm-256color

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs virtualenv)
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="001"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="255"
POWERLEVEL9K_BACKGROUND_JOBS_ICON="∞"
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="yellow"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="black"
POWERLEVEL9K_STATUS_OK_BACKGROUND="blue"
POWERLEVEL9K_STATUS_OK_FOREGROUND="blue"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black}  %F{black}"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_DELIMITER="…"
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

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

# Editor
export EDITOR='vim'
alias vi=vim

# Lang
# export LANG=C
export LANG="en_US.UTF-8"

# Grep colors
alias grep='grep --color'

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"

# GCC Colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Git aliases
# (overrides "git" plugin)
alias gd='git diff --color-moved'
alias gdca='git diff --cached --color-moved'
alias gdw='git diff --word-diff --color-moved'

# Golang
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.go/bin
export GOPATH=$HOME/.go

# Local binaries (=pip install --user)
export PATH=$PATH:$HOME/.local/bin

# Homebrew
HOMEBREW_NO_ANALYTICS=1
export PATH="/usr/local/sbin:$PATH"

# Brew paths
export PATH="/usr/local/opt/curl/bin:$PATH"

# export PATH="$HOME/.linuxbrew/bin:$PATH"
# export PATH="$HOME/.linuxbrew/sbin:$PATH"

# Turns out I am not a cow person.
export ANSIBLE_NOCOWS=1

# Helps you win your sanity back... Depends: fortune, lolcat, cowsay
alias insane="fortune | cowsay | lolcat"

# jrnl.sh
alias jrnlw="jrnl work"

# Pretty CSV viewer
# Taken from: https://chrisjean.com/view-csv-data-from-the-command-line/
csview() {
    cat $1 | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S
}

# Generate random password.
randpassw() {
    openssl rand -base64 12
}

# brew-la | Lists brew packages and dependencies, makes it easier for clean-ups.
# Copied from somewhere, can't remember its source though.
brew-la() {
    brew list -1 | while read cask; do echo -ne "\x1B[1;34m $cask \x1B[0m"; brew uses $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done
}

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

# mdf - Use FZF to search with mdfind (OS X) and save to clipboard.
# Searches by file name only.
mdf(){
    local DIR
    DIR=$(mdfind -name $1 | fzf )
    echo $DIR | pbcopy
}

# mdn - Use FZF to search with mdfind (OS X) and save to clipboard.
# All indexed files are included in its output.
mdn(){
    local DIR
    DIR=$(mdfind $1 | fzf )
    echo $DIR | pbcopy
}

# cheat - get cheatsheets from cheat.sh
# :list - lists all cheatsheets, ~keyword searches for keyword.
cheat(){
    curl cheat.sh/"$1" | less
}

# wttr - get weather from wttr.in
# usage: wttr <city>
wttr(){
    curl wttr.in/"$1" | less
}
