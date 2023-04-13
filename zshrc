# .zshrc
# - Yekta Leblebici <yekta@iamyekta.com>
# Depends: oh-my-zsh, powerlevel10k, fasd, fzf, fzf-zsh, zsh-autosuggestions
#
# Get dependencies by running:
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" (Not a great way to do this.)
#  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
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
ZSH_THEME="powerlevel10k/powerlevel10k"
source $HOME/.p10k.zsh

# Disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true

# Adding date & time stamps to 'history' command.
HIST_STAMPS="dd.mm.yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# TODO ssh-agent plugin is too slow, adds 0.2sec~ to startup.
plugins=(git \
         fasd \
         colored-man-pages \
         extract \
         docker \
         fzf-zsh \
         ssh-agent \
         gpg-agent \
         zsh-autosuggestions \
         zsh-interactive-cd \
         catimg \
         copybuffer \
         fancy-ctrl-z \
     )

# OS-specific plugins
# case "$OSTYPE" in
#   darwin*)
#       # For some reason aws plugin is extremely slow
#       # on my Fedora VM.
#       plugins+=('aws')
#     ;;
# esac

# OS-specific configuration
case "$OSTYPE" in
  darwin*)
      alias sed=gsed
    ;;
esac

# Lang
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Add your identity files below to have them automatically added.
zstyle :omz:plugins:ssh-agent identities id_ed25519
zstyle :omz:plugins:ssh-agent agent-forwarding on

# oh-my-zsh!
source $ZSH/oh-my-zsh.sh

## Completion tweaks
zstyle ':completion:*' use-ip true

# Completion for parent directory.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Keybinds
bindkey "^[[1;2D" backward-word
bindkey "^[[1;2C" forward-word
bindkey "^[[1;2A" beginning-of-line
bindkey "^[[1;2B" end-of-line

# Use ag as the default source.
# Depends on installed "ag", comment out these two if not.
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .terraform -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" 

# Consistent ordering between CTRL+R history search and CTRL+T.
export FZF_CTRL_R_OPTS="--reverse"

# Colors
alias grep='grep --color'
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"

# ag-like colors for ripgrep
alias rg='rg --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold'

# Editor
export EDITOR='nvim'
alias vi=nvim
alias vim=nvim

# Git aliases
# (overrides "git" plugin)
alias gd='git diff --color-moved'
alias gdca='git diff --cached --color-moved'
alias gdw='git diff --word-diff --color-moved'
alias gp='git push origin HEAD'
alias gst='git status --column'
alias groot='cd $(git rev-parse --show-toplevel)'

# Aliases
alias k='kubectl'
alias cidr='sipcalc'

# Golang
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.go/bin
export GOPATH=$HOME/.go

# Local binaries (=pip install --user)
export PATH=$PATH:$HOME/.local/bin

# homebrew
HOMEBREW_NO_ANALYTICS=1
export PATH="/usr/local/sbin:$PATH"

# awscli
export AWS_PAGER=""

# Brew paths
export PATH="/usr/local/opt/curl/bin:$PATH"

# Linuxbrew
export PATH="$HOME/.linuxbrew/bin:$PATH" # LINUX
export PATH="$HOME/.linuxbrew/sbin:$PATH" # LINUX

# Turns out I am not a cow person.
export ANSIBLE_NOCOWS=1

# Helps you win your sanity back... Depends: fortune, lolcat, cowsay
alias insane="fortune | cowsay | lolcat"

# jrnl.sh
alias jrnlw="jrnl work"

# cheat
alias cheat="CHEATCOLORS=true cheat"

# Pretty CSV viewer
# Taken from: https://chrisjean.com/view-csv-data-from-the-command-line/
csview() {
    cat $1 | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S
}

# Generate random password.
randpassw() {
    openssl rand -base64 48 | tr -d "=+/" | cut -c1-32
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

# fbr - git checkout branches with FZF
fbr() {
  local branches branch
  branches=$(git --no-pager branch --all -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //" | rev | cut -d "/" -f1 | rev)
}

# fcs - FZF command to get commit sha, useful combined with git commands.
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fdif - FZF command to get diff between two commits, interactively. 
# Requires fcs() function to work.
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

# cheatsh - get cheatsheets from cheat.sh
# :list - lists all cheatsheets, ~keyword searches for keyword.
cheatsh(){
    curl -s cheat.sh/"$1" | less
}

# wttr - get weather from wttr.in
# usage: wttr <city>
wttr(){
    curl -s wttr.in/"$1" | less
}
