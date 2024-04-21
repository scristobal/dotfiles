# Notes

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
- installed neofetch with apt
- not installed:  pyenv, nvm, mona lisa font, zoxide
- failed to install: tmux, Tabby

### Resolutions/changes

- Create a new `precheck.sh` to check which apps are installed.
- Remove checks from `.zshrc` to speed up launch times.
- Use `.antigenrc` file for catching and faster boot times.
