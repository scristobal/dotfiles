Fantastic `dotfiles` and where to find them.

Best used in combination with GNU Stow, eg $ stow --no-folding zsh.

Television
----------
Only custom or locally modified channels and their helper scripts are tracked.
Install from this repository directory:

    stow --no-folding television
    tv update-channels

Always use --no-folding when stowing Television (including bulk stow commands).
This keeps ~/.config/television/cable a real directory: custom channels are
individual symlinks, while downloaded upstream channels stay outside Git.
Stow custom channels before downloading upstream ones to avoid name conflicts.
Avoid tv update-channels --force: it can overwrite custom channels.

If Television was previously stowed without --no-folding, unstow it first:

    stow -D television
    stow --no-folding television
    tv update-channels

Tested on Arch and Asahi-Fedora and macOS.

