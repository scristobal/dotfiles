#!/bin/bash

command=alacritty
install_brew=alacritty
install_apt=alacritty

# test whether the scripts shoudl run
if [[ ! "$OSTYPE" == "darwin"* ]] && [[ ! "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Platform or OS not supported. Exiting"
    exit 1
fi

# Check if installed already
if ! command -v $command >/dev/null 2>&1; then
    echo "$command is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install $install_brew
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt install -y $install_apt
    fi
else
    echo "$command is installed."
fi
