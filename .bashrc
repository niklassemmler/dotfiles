# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTTIMEFORMAT="%d/%m/%y %T "
export PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsx='ls --sort=extension --group-directories-first'

alias gitgraph='git log --graph --decorate --pretty=oneline --abbrev-commit'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

export PS1="\[\e[33m\]\W\[\e[m\]-> "
#export PS1="\[\e[32m\]\u@\h\[\e[m\]:\[\e[33m\]\W\[\e[m\]-> "
# GIT bash integration
#if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
#
#  source /usr/lib/git-core/git-sh-prompt
#
#  export GIT_PS1_SHOWCOLORHINTS=true
#  export GIT_PS1_SHOWDIRTYSTATE=true
#  export GIT_PS1_SHOWSTASHSTATE=true
#  export GIT_PS1_SHOWUNTRACKEDFILES=true
#  #export GIT_PS1_SHOWUPSTREAM="auto"
#  # PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
#
#  # use existing PS1 settings
#  #PROMPT_COMMAND=$(sed -r 's|^(.+)(\\\$\s*)$|__git_ps1 "\1" "\2"|' <<< $PS1)
#  #PROMPT_COMMAND="__git_ps1  $PS1"
#  PROMPT_COMMAND='__git_ps1 "<\$(basename \"\$CONDA_DEFAULT_ENV\")> \[\e[33m\]\W\[\e[m\]" "-> "'
#  export PROMPT_COMMAND
#fi

[ "x$(which python3)x" == "xx" ] && alias python="python3"
[ "x$(which ipython3)x" == "xx" ] && alias ipython="ipython3"
[ "x${DISPLAY}x" == "xx" ] && export DISPLAY=localhost:0

[ -f "$HOME/.bashrc_local.sh" ] && source $HOME/.bashrc_local.sh

if [ "x${TMUX}x" == "xx" -a "x${COLORTERM}x" == "xx" -a "x$(which tmux)x" != "xx" ]; then 
  tmux attach || tmux
  [ "$?" == "0" ] && exit
fi
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
