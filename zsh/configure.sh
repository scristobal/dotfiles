#!/bin/bash

dotfiles_dir="$HOME/dotfiles/zsh" # dotfiles git directory
file=".zshrc"
backup_file="${file}_$(date '+%Y%m%d_%H%M%S').backup"

if [[ -f $HOME/$file ]]; then
    echo "Backing up existing $file as $backup_file"
    mv "$HOME/$file" "$HOME/$backup_file"
fi

echo "Creating symlink from $dotfiles_dir/$file to $HOME/$file in home directory."
ln -sf "$dotfiles_dir/$file" "$HOME/$file"
