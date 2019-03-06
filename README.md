# Summary of my dotfiles

Don't forget to pull the submodules too:

git submodule update --init --recursive

The goal is to share config files that are needed for setting up the basic
services between machines.

Almost all files have to be copied or linked to the home directory.

Exceptions are:
- `etc/` -- are related to configfiles in etc
- `terminator_config` -- needs to be linked to ~/.config/terminator/config
