# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

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
# TODO change on linux

# start applications
alias -s tex=vim
alias -s pl=vim
alias -s py=vim
alias -s bashrc=vim
alias -s zshrc=vim
alias -s txt=vim

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
