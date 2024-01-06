#!/bin/bash

# List of stow packages
packages=("alacritty" "tmux" "vim")

# Check if stow command is available
if command -v stow >/dev/null 2>&1; then
    echo "Stow command found. Running 'stow' for the following packages:"

    # Loop through each package and run stow
    for package in "${packages[@]}"; do
        echo "- $package"
        stow "$package"
    done
else
    echo "Stow command not found."

    # Check if running on macOS
    if [[ $(uname) == "Darwin" ]]; then
        echo "Do you want to install stow using Homebrew? (y/n)"
        read -r response

        if [[ $response =~ ^[Yy]$ ]]; then
            brew install stow

            echo "Stow installed successfully. Do you want to run this script again? (y/n)"
            read -r run_again

            if [[ $run_again =~ ^[Yy]$ ]]; then
                exec "$0"
            fi
        else
            echo "Please install stow manually and re-run this script."
        fi
    else
        echo "Please install stow manually and re-run this script."
    fi
fi
