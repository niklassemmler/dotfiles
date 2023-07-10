#!/bin/bash
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"
cargo install ripgrep
cargo install fd-find
cargo install exa
cargo install fzf
