#!/bin/bash
curl https://sh.rustup.rs -sSf | bash -s -- -y
source "$HOME/.cargo/env"
cargo install ripgrep
cargo install fd-find
cargo install exa
