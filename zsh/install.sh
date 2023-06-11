#!/bin/bash

# test whether the scripts shoudl run
if [[ ! "$OSTYPE" == "darwin"* ]] && [[ ! "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Platform or OS not supported. Exiting"
    exit 1
fi

# Check for zsh
if ! command -v zsh >/dev/null 2>&1; then
    echo "zsh is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh git
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt install -y zsh git
    fi
else
    echo "zsh is installed."
fi

# Check for antigen
if [ ! -f "$HOME/.antigen/antigen.zsh" ]; then
    echo "antigen is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install antigen
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -L git.io/antigen >antigen.zsh
    fi
else
    echo "antigen is installed."
fi

# Set the default shell to zsh if it isn't currently set to zsh
if [[ ! $($SHELL) == $(which zsh) ]]; then
    chsh -s "$(which zsh)"
fi

source "zsh/configure.sh"
