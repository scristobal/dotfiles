#!/bin/bash

command=alacritty
dotfiles_dir="$HOME/dotfiles/$command" # dotfiles git directory

file=".alacritty.yml"
config_dir=$HOME
backup_file="${file}_$(date '+%Y%m%d_%H%M%S').backup"

if [[ -f $config_dir/$file ]]; then
    echo "Backing up existing $file as $backup_file"
    mv "$config_dir/$file" "$config_dir/$backup_file"
fi

echo "Creating symlink from $dotfiles_dir/$file to $config_dir/$file in home directory."
ln -sf "$dotfiles_dir/$file" "$config_dir/$file"
