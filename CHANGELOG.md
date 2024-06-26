# CHANGELOG

## 20-Apr-2024: Installing Ubuntu 24.10

### Issues/notes

- could not install Tabby due to missing dependencies
- alacritty installed with snap -> <https://snapcraft.io/alacritty>
  - remove 'Mono' in the font name,
  - decrease size to 10.0,
  - can not hide tittle bar in Linux
  - removed padding
  - forced dimensions at start
- needed to install zsh with apt and make it default `chsh -s $(which zsh)` don't forget to logout!! -> <https://askubuntu.com/a/131838>
- install antigen -> <https://github.com/zsh-users/antigen?tab=readme-ov-file#installation>
- needed to install fzf manually
- installed rust w/ rustup
- installed exa and zoxide with cargo, but do not install Alacritty this way!
- script to install oh my posh (themes) did not run on ubuntu (something is wrong with this condition `[[ $(uname) == 'Linux' ]] && [[ $(uname -m) == 'x86_64' ]]`
- font script worked like a charm, at least with Menlo (default)
- generated a new gpg key and added to GH using their CLI
- nvim config worked flawlessly
- installed neofetch with apt
- not installed:  pyenv, nvm, mona lisa font, zoxide
- failed to install: tmux, Tabby
- vscode config is not compatible w/ Linux:
  - need to remove `'Mono'` at the end of the font name, can be fixed by providing the fixed font name as a fallback
  - need to change the path of Zig's language server `"zig.zls.path"` inside settings.json

### Resolutions/changes

- Create a new `precheck.sh` to check which apps are installed.
- Remove checks from `.zshrc` to speed up launch times.
- Use `.antigenrc` file for catching and faster boot times.
- Adapted alacritty config to Linux, which broke macOS.

### Unresolved

- Find a way to switch macOS flags on/off on Alacritty config.
