#!/bin/bash

# Set output_file to 'Brewfile_' followed by a timestamp (e.g., Brewfile_20211201_123456.backup)
output_file="Brewfile_$(date '+%Y%m%d_%H%M%S').backup"

# Initialize brewfile_exists to 0 (assuming no existing Brewfile)
brewfile_exists=0

# Check if Brewfile exists in the current directory
if [ -f "Brewfile" ]; then
    # Set brewfile_exists to 1 (indicating Brewfile exists)
    brewfile_exists=1

    # Prompt the user to back up the old Brewfile and run 'brew bundle dump'
    echo "Brewfile exists. Do you want to back up the old one with the date appended and execute 'brew bundle dump'? [y/n]"

    # Read the user's input
    read -r user_input
fi

# If there is no existing Brewfile or the user input is 'y'
if [ "$brewfile_exists" -eq 0 ] || [ "$user_input" == "y" ]; then
    # If an existing Brewfile was found
    if [ "$brewfile_exists" -eq 1 ]; then
        # Back up the existing Brewfile with a new name (including date info)
        cp Brewfile "$output_file"
    fi

    # Dump the Brewfile
    brew bundle dump

    # Save the descriptions of the leaves installed on request to a text file, also with a timestamp (e.g., brew_20211201_123456)
    brew leaves --installed-on-request | xargs -n1 brew desc --eval-all >"brew_$(date '+%Y%m%d_%H%M%S')"
fi
