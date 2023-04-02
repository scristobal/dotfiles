#!/bin/bash

# This script checks if Homebrew is installed on a macOS system and installs it if it's not present.

# Print a message about checking the Homebrew installation
echo "Checking on brew..."

# Check if the operating system is macOS (Darwin)
if [[ $(uname) == 'Darwin' ]]; then

    # Check if the 'brew' command exists
    if command -v brew >/dev/null 2>&1; then
        # If Homebrew is installed, show a message
        echo "Homebrew is installed"
    else
        # Otherwise, install Homebrew
        echo "Homebrew is not installed, installing ..."
        curl -SL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
    fi
else
    # Show a message if the operating system is not supported
    echo "Unsupported"
fi
