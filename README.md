# dotfiles

Fantastic `dotfiles` and where to find them

## How to get started

Run [precheck.sh](./precheck.sh) to perform a harmless system checkup, install stuff until is all green.

## What is included/recommended?

### Terminal

- [x] nvim
- [x] git
- [x] GitHub CLI
- [x] gpg
- [ ] curl
- [ ] docker
- [x] zsh +  `chsh -s $(which zsh)`
- [x] alias
- [x] [oh-my-zsh](https://ohmyz.sh)
- [ ] [oh-my-posh](https://ohmyposh.dev/)
- [x] [nerd fonts](./helpers/install_nerdfonts_from_source.sh)
- [x] tmux
- [x] fzf

### Command Line Interfaces

- [ ] jq
- [x] neofetch
- [ ] [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation) (cat++)
- [ ] [tailspin](https://github.com/bensadeh/tailspin?tab=readme-ov-file#installing)
- [ ] [curlie](https://github.com/rs/curlie?tab=readme-ov-file#install) (curl++)
- [ ] [glow](https://github.com/charmbracelet/glow?tab=readme-ov-file#installation) (render `.md` files)
- [ ] [btop](https://github.com/aristocratos/btop?tab=readme-ov-file#installation) (top+++)
- [ ] [ncdu](https://code.blicky.net/yorhel/ncdu/) (du+++)
- [ ] [fx](https://fx.wtf/install#installation) (jq++)
- [ ] [broot](https://github.com/Canop/broot) (finder)
- [ ] [ncspot](https://github.com/hrkfdn/ncspot?tab=readme-ov-file#installation) (spotify)
- [ ] [monolith](https://github.com/y2z/monolith) (save HTML single file)
- [ ] yt-dlp (youtube downloader)
- [ ] [topgrade](https://github.com/topgrade-rs/topgrade?tab=readme-ov-file#installation) (automatic tool upgrades, apparently)

### Programing

- [ ] [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)
- [x] [rustup](https://rustup.rs/)
- [x] [zigup](https://github.com/marler8997/zigup) or [zvm](https://www.zvm.app/)
- [ ] [pyenv](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation)
- [ ] [go](https://go.dev/doc/install#extra_versions)

### Applications

- [x] [alacritty](https://alacritty.org/) + [themes](https://github.com/alacritty/alacritty-theme)
- [x] vscode
- [x] [break-timer](https://github.com/tom-james-watson/breaktimer-app)
- [x] firefox
- [x] [proton mail](https://proton.me/mail/download)
- [x] [proton VPN](https://protonvpn.com/support/official-ubuntu-vpn-setup/)
- [ ] sublime
- [ ] [hyper](https://hyper.is/)
- [ ] [tabby](https://tabby.sh)
- [x] spotify
- [x] telegram
- [ ] [emote](https://snapcraft.io/emote)
- [ ] font-manager

### Rustacean

- [ ] nushell (shell)
- [x] starship (oh-my-posh)
- [ ] zellij (tmux)
- [x] exa (ls++)
- [x] zoxide (cd++)
- [ ] fnm (nvm)
- [ ] [dust](https://github.com/bootandy/dust) (du+++)
- [ ] [ripgrep](https://github.com/BurntSushi/ripgrep) (grep++)
- [ ] [fd](https://github.com/sharkdp/fd) (find++)
- [ ] [skim](https://github.com/lotabout/skim?tab=readme-ov-file) (fzf)
- [ ] [hyperfine](https://github.com/sharkdp/hyperfine?tab=readme-ov-file#installation) (time++)
- [x] [difft](https://difftastic.wilfred.me.uk/installation.html) (diff++)
- [ ] [tealdeer](https://github.com/dbrgn/tealdeer?ref=itsfoss.com) (tldr)
- [ ] [procs](https://github.com/dalance/procs) (ps++)
- [ ] [macchina](https://github.com/Macchina-CLI/macchina/wiki/Installation) (neofetch)
- [ ] [ouch](https://github.com/ouch-org/ouch?tab=readme-ov-file#installation) (de/compress)
- [ ] lapce (vsc)
- [ ] zed (vsc)

## Extra notes

- Add support for [latest mesa drivers](https://linuxconfig.org/install-and-test-vulkan-on-linux) PPA `bash sudo add-apt-repository ppa:graphics-drivers/ppa`

- Additional video formats `sudo apt-get install ubuntu-restricted-extras libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg`

## Other dotfiles and tools

- <https://github.com/mhartington/dotfiles>
- <https://github.com/Matsuuu/dotfiles>
- <https://github.com/mhartington/dotfiles/tree/main/config/fonts>
- <https://github.com/adrg/xdg>
