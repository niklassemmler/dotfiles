# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/magum/.zshrc'

#bindkey -v
#bindkey "^P" vi-up-line-or-history
#bindkey "^N" vi-down-line-or-history
#
#bindkey "^[[1~" vi-beginning-of-line   # Home
#bindkey "^[[4~" vi-end-of-line         # End
#bindkey '^[[2~' beep                   # Insert
#bindkey '^[[3~' delete-char            # Del
#bindkey '^[[5~' vi-backward-blank-word # Page Up
#bindkey '^[[6~' vi-forward-blank-word  # Page Down
autoload -Uz compinit
compinit
# End of lines added by compinstall
export PYTHONSTARTUP=~/.pythonrc
export NCS_DIR=/Users/pharaoh/dev/tail-f/ncs-3.0.1/
export CONFD_DIR=/Users/pharaoh/dev/tail-f/confd-5.0/
# TODO change on linux
export PYTHONBIN=~/Library/Python/2.7/bin
export ANT_HOME="/Users/pharaoh/dev/ant"
PATH=$PYTHONBIN:/Users/pharaoh/bin:/opt/local/bin:/usr/local/bin/:$PATH
PATH=/opt/local/sbin:/usr/local/sbin:$ANT_HOME/bin:$PATH
PATH=/Users/pharaoh/dev/ns-allinone-2.35/bin:$PATH
PATH=$CONFD_DIR/bin/:$NCS_DIR/bin/:$PATH
export PATH=/Users/pharaoh/dev/ns-allinone-2.35/bin:$PATH
LD_PATH=/Users/pharaoh/dev/ns-allinone-2.35/otcl-1.14:$LD_PATH
export LD_PATH=/Users/pharaoh/dev/ns-allinone-2.35/lib:$LD_PATH
export TCL_LIBRARY=/Users/pharaoh/dev/ns-allinone-2.35/tcl8.5.10/library:$TCL_LIBRARY
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export MANPATH=$CONFD_DIR/man/:$NCS_DIR/man/:$MANPATH

# start applications
alias -s tex=vim
alias -s pl=vim
alias -s py=vim
alias -s bashrc=vim
alias -s zshrc=vim
alias -s txt=vim
alias ls="ls -G"

# set aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g DN=/dev/null
alias -g LL="2>&1 | less"
alias -g GR="| grep"
alias -g PS="ps -ef | grep"
alias -g L="| less"
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'
alias -g l='less'
alias -g v='vim'
alias -g vi='vim'

# first test of completion
setopt AUTO_LIST AUTO_MENU
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=10
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# go through dirs with <ENTER>
setopt autocd autopushd pushdignoredups

if [ -e ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
. $NCS_DIR/ncsrc
. $CONFD_DIR/confdrc

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Disable interpreting Control S and some more ...
stty -ixon
