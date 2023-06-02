# Summary of my dotfiles

Don't forget to pull the submodules too:

git submodule update --init --recursive

The goal is to share config files that are needed for setting up the basic
services between machines.

Almost all files have to be copied or linked to the home directory.

Exceptions are:
- `etc/` -- are related to configfiles in etc
- `terminator_config` -- needs to be linked to ~/.config/terminator/config

## TODO: Make installation easier

Levels of installation of config

- bashrc, inputrc
- vim, tmux
- zshrc, terminator, ...
- xmonadrc

## Tools

- bat --- better cat
- exa -- better ls
- delta -- better git show 
- ripgrep -- better grep
- fd -- better find
- fzf -- list

On Ubuntu:

`sudo apt install fd-find bat exa fzf ripgrep`

And for delta

https://github.com/dandavison/delta/releases
