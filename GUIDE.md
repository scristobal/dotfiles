# System Checklist

Terminal 📟

- [x] nvim
- [x] git
- [ ] GitHub CLI
- [ ] gpg
- [ ] curl
- [ ] docker
- [x] zsh
- [x] alias
- [x] [oh-my-zsh](https://ohmyz.sh)
- [x] [oh-my-posh](https://ohmyposh.dev/)
- [x] nerd font
- [x] tmux
- [ ] fzf
- [x] neofetch

Programing 🤖

- [x] nvm or fnm
- [ ] go
- [ ] rust
- [ ] python

Applications 🖥️

- [x] [alacritty](https://alacritty.org/)
- [ ] vscode
- [ ] [break-timer](https://github.com/tom-james-watson/breaktimer-app)
- [ ] firefox
- [ ] proton
- [ ] sublime
- [ ] [hyper](https://hyper.is/)
- [ ] [tabby](https://tabby.sh)
- [ ] spotify
- [ ] telegram
- [ ] slack

Darwin only 🍏

- [ ] [xcodes](https://github.com/XcodesOrg/xcodes)
- [x] [brew](https://brew.sh)
- [ ] sudo-touchid
- [ ] [Mac Apple Store CLI](https://github.com/mas-cli/mas)
- [ ] iina
- [ ] whalebrew
- [ ] tgpro
- [ ] parallels
- [ ] reeder

Linux only 🐧

- [ ] [emote](https://snapcraft.io/emote)
- [ ] font-manager

Rustacean 🦀

- [ ] nushell (zsh)
- [ ] starship (oh-my-posh)
- [ ] zellij (tmux)
- [x] exa (ls)
- [x] zoxide (cd)
- [ ] fnm (nvm)
- [ ] lapce (vsc)
- [ ] zed (vsc)

Additional steps🪜

- [ ] Make zsh default shell

```bash
chsh -s $(which zsh)
```

- [ ] Launch Sublime from terminal with `subl`

```bash
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/.
```

- [ ] Add support for latest mesa drivers PPA  [more](https://linuxconfig.org/install-and-test-vulkan-on-linux):

```bash
sudo add-apt-repository ppa:graphics-drivers/ppa
```

- [ ] Additional video formats

```bash
sudo apt-get install ubuntu-restricted-extras libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg
```
