# ~/.bashrc: executed by bash(1) for non-login shells.
# Yekta Leblebici <yekta@iamyekta.com>, based on Debian's stock .bashrc file.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history size and history file size.
HISTSIZE=2000
HISTFILESIZE=10000

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Load alias definitions if they exist.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Powerline
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bindings/bash/powerline.sh
fi

# Styling
export TERM=xterm-256color
export GREP_OPTIONS="--color"

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go

# Vim
export EDITOR="vim"

# Helps you win your sanity back... Depends: fortune, lolcat, cowsay
alias insane="fortune | cowsay | lolcat "

# Fasd
alias a='fasd -a'
alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'
# function to execute built-in cd
fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
  fi
}
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'

_fasd_prompt_func() {
  eval "fasd --proc $(fasd --sanitize $(history 1 | \
    sed "s/^[ ]*[0-9]*[ ]*//"))" >> "/dev/null" 2>&1
}

# add bash hook
case $PROMPT_COMMAND in
  *_fasd_prompt_func*) ;;
  *) PROMPT_COMMAND="_fasd_prompt_func;$PROMPT_COMMAND";;
esac

# bash command mode completion
_fasd_bash_cmd_complete() {
  # complete command after "-e"
  local cur=${COMP_WORDS[COMP_CWORD]}
  [[ ${COMP_WORDS[COMP_CWORD-1]} == -*e ]] && \
    COMPREPLY=( $(compgen -A command $cur) ) && return
  # complete using default readline complete after "-A" or "-D"
  case ${COMP_WORDS[COMP_CWORD-1]} in
    -A|-D) COMPREPLY=( $(compgen -o default $cur) ) && return;;
  esac
  # get completion results using expanded aliases
  local RESULT=$( fasd --complete "$(alias -p $COMP_WORDS \
    2>> "/dev/null" | sed -n "\$s/^.*'\\(.*\\)'/\\1/p")
    ${COMP_LINE#* }" | while read -r line; do
      quote_readline "$line" 2>/dev/null || \
        printf %q "$line" 2>/dev/null  && \
        printf \\n
    done)
  local IFS=$'\n'; COMPREPLY=( $RESULT )
}
_fasd_bash_hook_cmd_complete() {
  for cmd in $*; do
    complete -F _fasd_bash_cmd_complete $cmd
  done
}

# enable bash command mode completion
_fasd_bash_hook_cmd_complete fasd a s d f sd sf z zz

alias v="f -e vim -b viminfo"
alias o="a -e xdg-open"
_fasd_bash_hook_cmd_complete v o 
