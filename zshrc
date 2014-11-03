# [[ -z "$TMUX" ]] && exec tmux
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt EXTENDEDGLOB NOTIFY

# start applications
alias -s tex=vim
alias -s pl=vim
alias -s bashrc=vim
alias -s zshrc=vim
alias -s txt=vim
alias -s html=chromium
alias -s htm=chromium

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
alias -g t='todo.sh'
alias -g s='sudo'
alias -g lt='ls -t | head -30'
alias -g chromium='chromium --password-store=gnome'

# first test of completion
autoload -Uz compinit
compinit
setopt AUTO_LIST AUTO_MENU
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=10
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# go through dirs with <ENTER>
setopt AUTOCD AUTOPUSHD PUSHDIGNOREDUPS

if [ -e ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
