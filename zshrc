## Required
# export DOTFILES_DIR="$HOME/dotfiles"
# export ANTIDOTE_DIR="$HOME/.antidote"
## Zsh packages (Antidote)
# install with homebrew or linux package manager

# source antidote
source $ANTIDOTE_DIR/antidote.zsh
 
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Oh My ZSH config
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'icons' yes

# Setup keys for substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

## Variables
EDITOR="nvim"
PATH=${HOME}/.local/bin/:$PATH
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE
WORDCHARS="${WORDCHARS}._-()[]{}"
export PATH HISTFILE HISTSIZE SAVEHIST WORDCHARS

## Options
# History
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY


setopt EXTENDED_GLOB
setopt NOTIFY

# Directory management
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

## Completion
autoload -Uz compinit
compinit
setopt AUTO_LIST AUTO_MENU
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=10
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:cd:*' ignore-parents parent pwd # never autocomplete parent dir
zstyle ':completion:*:kill:*' verbose yes # show description for kill

## Loading programs
autoload zmv
autoload colors
colors

## Scripts
function mkcd () {
    mkdir -pv "$@" && cd "$@" 
}

function vimcd () {
    cd "${@:h}" && vim "${@:t}"
}

function sudo_call () {
    BUFFER="sudo $BUFFER"
    CURSOR=$#BUFFER
}
zle -N sudo_call

function background_call () {
    VAR="$(mktemp -u)"
    BUFFER="nohup $BUFFER >${VAR}.out 2>${VAR}.err &"
    CURSOR=$#BUFFER
}
zle -N background_call

function rationalise-dot () {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot

function goto {
  # 1. Ensure we are in a git repo
  git rev-parse --is-inside-work-tree > /dev/null 2>&1 || { echo "Not a git repository"; return 1; }

  # 2. Get branches, filter through fzf, and store in a variable
  local target
  target=$(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)" | 
           fzf --preview 'git log -n 5 --color=always {}' --height 40% --layout=reverse --border --prompt="Checkout Branch > ")

  # 3. If a target was selected (user didn't hit ESC), checkout
  if [[ -n "$target" ]]; then
    git switch "$target"
  fi
}

# Rebase current branch onto latest main
function rbmain {
  # 1. Check for dirty working directory
  if ! git diff-index --quiet HEAD --; then
    echo "Error: You have uncommitted changes. Stash or commit them first."
    return 1
  fi

  # 2. Update local main and rebase
  echo "Updating main and rebasing..."
  git fetch origin main:main && git rebase main
  
  # 3. Ask to force push if rebase was successful
  if [ $? -eq 0 ]; then
    echo -n "Rebase successful. Force push to origin? (y/n) "
    read -k 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      git push --force-with-lease
    fi
  fi
}

gh_search() {
  if [ -z "$1" ]; then
    echo "Usage: gh_search <search-string>"
    return 1
  fi
  gh search code "$1" --owner="$GITHUB_ORG"
}

gh_web() {
  if [ -z "$1" ]; then
    echo "Usage: gh_web <search-string>"
    return 1
  fi
  # We embed the org filter directly in the query to avoid the CLI redirection bug
  gh search code "$1 org:$GITHUB_ORG" --web
}

function hl {
  sed -E "s/$1/$(tput setaf 5)$1$(tput sgr0)/"
}

function kns {
  kubectl config set-context --current --namespace=$1
}

# Go UP/DOWN locally
up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history

## Key mapping
bindkey '^[s' sudo_call
bindkey '^[a' background_call 
bindkey . rationalise-dot
bindkey -M isearch . self-insert # so that search works

# Setup key to temporarily store lines
bindkey -M viins '^Q' push-line
bindkey -M vicmd '^Q' push-line

## Powerline
source $DOTFILES_DIR/p10k.zsh

# Load the edit-command-line function
autoload -Uz edit-command-line
zle -N edit-command-line

# Bind it to a shortcut (Ctrl-x, Ctrl-e is the standard convention)
bindkey '^x^e' edit-command-line

# iterm2 
function iterm2_print_user_vars() {
  iterm2_set_user_var gitProject $(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
}
