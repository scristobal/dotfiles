#!/bin/bash

# Check if Brewfile exists in the current directory
if [ ! -f "Brewfile" ]; then
    echo "No Brewfile found. Exiting."
    exit 1
fi

# Count the number of modules to be installed
module_count=$(grep -c -E '^(brew|mas|cask|tap) ' Brewfile)

# Warn the user about the number of modules to be installed
echo "This will install $module_count modules. Are you sure you want to proceed? [y/n]"

# Read the user's input
read -r user_input

# If the user input is 'y', proceed with 'brew bundle'
if [ "$user_input" == "y" ]; then
    brew bundle
else
    echo "Operation cancelled."
    exit 0
fi
