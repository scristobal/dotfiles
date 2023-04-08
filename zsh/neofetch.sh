#!/bin/bash

# test whether the platform is supported

if [[ ! "$(uname)" == "Linux" ]] && [[ ! "$(uname)" == "Darwin" ]]; then
    echo "Platform or OS not supported. Exiting"
    exit 1
fi

if ! command -v neofetch >/dev/null 2>&1; then
    echo "Neofetch is not installed. Instaling..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install neofetch
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt install -y neofetch
    fi
fi

# NEOFETCH_DIR="$HOME/.neofetch"

# if [[ ! -d "$NEOFETCH_DIR" ]] || [ -z "$(\ls -A $NEOFETCH_DIR)" ]; then
#     echo "Neofetch not found, installing..."
#     git clone https://github.com/dylanaraps/neofetch "$NEOFETCH_DIR"
#     cd "$NEOFETCH_DIR"
#     git checkout $(git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1))
#     sudo make PREFIX=/usr/local install
#     cd ..
# fi

# alias neofetch='$HOME/.neofetch/neofetch'

# "$HOME/.neofetch/neofetch"
