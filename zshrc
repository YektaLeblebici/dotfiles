# .zshrc
# - Yekta Leblebici <yekta@iamyekta.com>
# Depends: fasd, fzf, ag
#
# Get dependencies by running:
#  brew install fasd
#  brew install ag

# Initialize mise
# pyenv was mighty slow, mise seems to run much better.
eval "$(/opt/homebrew/bin/mise activate zsh)"

# Load antidote and plugins
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# Initialize powerlevel10k
source $HOME/.p10k.zsh
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# Adding date & time stamps to 'history' command.
HIST_STAMPS="dd.mm.yyyy"

# OS-specific configuration
case "$OSTYPE" in
  darwin*)
      alias sed=gsed
    ;;
esac

# Lang
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

## Completion tweaks
zstyle ':completion:*' use-ip true
unsetopt menu_complete
setopt complete_in_word
setopt always_to_end

# Completion for parent directory.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'


# Keybinds
bindkey "^[[1;2D" backward-word
bindkey "^[[1;2C" forward-word
bindkey "^[[1;2A" beginning-of-line
bindkey "^[[1;2B" end-of-line

# pushd/popd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Shell behaviour
setopt multios              # enable redirect to multiple streams: echo >file1 >file2
setopt long_list_jobs       # show long list format job notifications
setopt interactivecomments  # recognize comments

# Use ag as the default source.
# Depends on installed "ag", comment out these two if not.
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .terraform -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Consistent ordering between CTRL+R history search and CTRL+T.
export FZF_CTRL_R_OPTS="--reverse"

source <(fzf --zsh)

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

# From https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

alias gd='git diff --color-moved'
alias gdca='git diff --cached --color-moved'
alias gdw='git diff --word-diff --color-moved'
alias gp='git push origin HEAD'
alias gst='git status --column'
alias groot='cd $(git rev-parse --show-toplevel)'
alias gc='git commit --verbose'
alias ga='git add'
alias gcm='git checkout $(git_main_branch)'
alias gf='git fetch'
alias grm='git rm'
alias gicp="git checkout -"

# Aliases
alias k='kubectl'
alias cidr='sipcalc'
alias k9s="k9s --readonly"
alias la='ls -la'
alias ll='ls -lh'

# Autocomplete directories like OMZ does
function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

# Golang
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.go/bin
export GOPATH=$HOME/.go

# Python
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Local binaries (=pip install --user)
export PATH=$PATH:$HOME/.local/bin

# Homebrew
HOMEBREW_NO_ANALYTICS=1
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Kubectl krew
export PATH="${PATH}:${HOME}/.krew/bin"

# Rancher desktop
export PATH="${PATH}:${HOME}/.rd/bin"

# awscli
export AWS_PAGER=""

# gcloud
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Brew paths
export PATH="/usr/local/opt/curl/bin:$PATH"

# Linuxbrew
# export PATH="$HOME/.linuxbrew/bin:$PATH" # LINUX
# export PATH="$HOME/.linuxbrew/sbin:$PATH" # LINUX

# Turns out I am not a cow person.
export ANSIBLE_NOCOWS=1

# Helps you win your sanity back... Depends: fortune, lolcat, cowsay
alias insane="fortune | cowsay | lolcat"

# jrnl.sh
alias jrnlw="jrnl work"

# cheat
alias cheat="CHEATCOLORS=true cheat"
alias cheats="cheat -l | fzf | cut -d' ' -f1 | CHEATCOLORS=true xargs cheat -e"

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

# fas - ag search with FZF
alias fas="ag --nobreak --nonumbers --noheading . | fzf"

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
  git checkout $(echo "$branch" | awk '{print $1}')
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


awsve () {
        AWS_ASSUME_ROLE_TTL=1h aws-vault exec $@
}

# for Macs only
alias google-chrome-stable='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

awsvl () {
        local TOKEN="$(aws-vault login -s $@)"
        if [[ $TOKEN =~ "signin.aws.amazon.com" ]]
        then
                local cache=$(mktemp -d /tmp/google-chrome-XXXXXX)
                local data=$(mktemp -d /tmp/google-chrome-XXXXXX)
                google-chrome-stable --no-first-run --new-window --disk-cache-dir=$cache --user-data-dir=$data $TOKEN
                rm -rf $cache $data
        else
                echo $TOKEN
        fi
}

linuxify (){
    if type brew &>/dev/null; then
        HOMEBREW_PREFIX=$(brew --prefix)
        for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
        for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
    fi
}

# Kubernetes helpers
# Usage: kubectlgetall <namespace>
function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i}
  done
}

# Create new branch from JIRA ticket
# Usage: jnewb(ranch) <branchname>
jnewb(){
    local BRANCH_NAME
    local BRANCH_PREFIX
    local TASK_ID
    BRANCH_PREFIX=$(jira me | cut -d'.' -f1)
    TASKS=$(jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled')"  -a $(jira me))
    TASK_ID=$(echo ${TASKS} | fzf | awk -F'\t+' '{print $2}')

    BRANCH_NAME="${BRANCH_PREFIX}/${TASK_ID}"

    if test -n "$1"
    then
    BRANCH_NAME="${BRANCH_NAME}_${1}"
    fi

    git checkout -b ${BRANCH_NAME}
}

# Format a message ready to post on Slack from Github PRs
# Usage: slackpr
# Thanks to Craig Huber (https://github.com/crhuber)
slackpr(){
    local PR_REPO
    local PR_ID
    local PR_INPUT
    local MSG

    local EMOJIS=("conga_parrot" "ship" "partywizard" "mario_walks" "mario_luigi_dance" "banana_dance" "deployparrot" "quad_parrot" "old_man_yells_at_github" "cat-roomba" "golden_star_spin")
    local RANDOM_EMOJI

    # Select a random emoji
    RANDOM_EMOJI=${EMOJIS[$((RANDOM % ${#EMOJIS[@]}))]:-"conga_parrot"}

    PR_INPUT=$(gh search prs --state=open --author=@me | fzf)
    PR_REPO=$(echo $PR_INPUT | cut -f1)
    PR_ID=$(echo $PR_INPUT | cut -f2)

    MSG=$(gh pr view $PR_ID --repo $PR_REPO --json url,title | jq -r "\"\(.title) \n:$RANDOM_EMOJI: \(.url)\"")
    echo "$MSG"
    echo "$MSG" | pbcopy
}

# Atuin
local FOUND_ATUIN=$+commands[atuin]

if [[ $FOUND_ATUIN -eq 1 ]]; then
  source <(atuin init zsh --disable-up-arrow)
fi

alias his="atuin search -i --inline-height 0"

# Fancy CTRL+Z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Edit the current command line in $EDITOR from OMZ
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
