# dotfiles

Fantastic `dotfiles` and where to find them

## How to get started

Run [precheck.sh](./precheck.sh) to perform a harmless system checkup, install stuff until is all green.

## What is included/recommended?

### Terminal

- [x] zsh ⭐️ +  `chsh -s $(which zsh)`
- [x] nvim ⭐️
- [x] git ⭐️
- [x] GitHub CLI
- [x] gnupg
- [x] stow ⭐️
- [x] curl
- [ ] docker
- [x] [oh-my-zsh](https://ohmyz.sh) ⭐️
- [x] [nerd fonts](./helpers/install_nerdfonts_from_source.sh) ⭐️
- [x] tmux ⭐️
- [x] fzf
- [ ] jq
- [x] neofetch
- [x] [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation) 🦀 (cat++)
- [ ] [tailspin](https://github.com/bensadeh/tailspin?tab=readme-ov-file#installing) 🦀
- [ ] [curlie](https://github.com/rs/curlie?tab=readme-ov-file#install) 🦫 (curl++)
- [ ] [glow](https://github.com/charmbracelet/glow?tab=readme-ov-file#installation) 🦫 (render `.md` files)
- [ ] [btop](https://github.com/aristocratos/btop?tab=readme-ov-file#installation) (top+++)
- [ ] [ncdu](https://code.blicky.net/yorhel/ncdu/) 🦎 (du+++)
- [ ] [fx](https://fx.wtf/install#installation) 🦫 (jq++)
- [ ] [broot](https://github.com/Canop/broot) 🦀 (finder)
- [ ] [ncspot](https://github.com/hrkfdn/ncspot?tab=readme-ov-file#installation) 🦀 (spotify)
- [ ] [monolith](https://github.com/y2z/monolith) (save HTML single file)
- [ ] yt-dlp (youtube downloader)
- [ ] [topgrade](https://github.com/topgrade-rs/topgrade?tab=readme-ov-file#installation) (automatic tool upgrades, apparently)
- [x] [nushell](https://www.nushell.sh/book/installation.html#build-using-crates-io) 🦀 (shell)
- [x] starship 🦀 (oh-my-posh)
- [ ] zellij 🦀 (tmux)
- [x] exa 🦀 (ls++) ⭐️
- [x] zoxide 🦀 (cd++) ⭐️
- [ ] fnm 🦀 (nvm)
- [ ] [dust](https://github.com/bootandy/dust) 🦀 (du+++)
- [ ] [ripgrep](https://github.com/BurntSushi/ripgrep) 🦀 (grep++)
- [ ] [fd](https://github.com/sharkdp/fd) 🦀 (find++)
- [ ] [skim](https://github.com/lotabout/skim?tab=readme-ov-file) 🦀 (fzf)
- [ ] [hyperfine](https://github.com/sharkdp/hyperfine?tab=readme-ov-file#installation) 🦀 (time++)
- [ ] [oha](https://github.com/hatoo/oha) 🦀 ([hey](https://github.com/rakyll/hey))
- [x] [difft](https://difftastic.wilfred.me.uk/installation.html) 🦀 (diff++)
- [ ] [tealdeer](https://github.com/dbrgn/tealdeer?ref=itsfoss.com) 🦀 (tldr)
- [ ] [procs](https://github.com/dalance/procs) 🦀 (ps++)
- [ ] [macchina](https://github.com/Macchina-CLI/macchina/wiki/Installation) 🦀 (neofetch)
- [ ] [ouch](https://github.com/ouch-org/ouch?tab=readme-ov-file#installation) 🦀 (de/compress)
- [x] [exercisim CLI](https://exercism.org/cli-walkthrough)

### Programing

- [x] [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating) 📦️⭐️
- [x] [rustup](https://rustup.rs/) 🦀⭐️
- [x] [zigup](https://github.com/marler8997/zigup) (or [zvm](https://www.zvm.app/))
- [ ] [pyenv](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation) + [poetry](https://python-poetry.org/docs/#installation)
- [ ] [go](https://go.dev/doc/install#extra_versions)
- [ ] [Lua](https://www.lua.org/download.html)
- [x] [Playdate SDK](https://play.date/dev/) + [Mirror](https://play.date/mirror/) + [project template](https://github.com/scristobal/playdate-c-api-experiments)
- [x] cmake
- [x] [gfortran](https://fortran-lang.org/learn/os_setup/install_gfortran/#linux)

### Applications

- [x] [alacritty](https://alacritty.org/) ⭐️ + [themes](https://github.com/alacritty/alacritty-theme)
- [x] vscode ⭐️
- [x] [break-timer](https://github.com/tom-james-watson/breaktimer-app)
- [x] firefox ⭐️ + nightly
- [x] [chromium](https://snapcraft.io/chromium) + canary
- [x] [proton pass](https://proton.me) ⭐️
- [x] [proton mail](https://proton.me/mail/download)
- [x] [proton vpn](https://protonvpn.com/support/official-ubuntu-vpn-setup/)
- [ ] sublime
- [ ] [hyper](https://hyper.is/)
- [ ] [tabby](https://tabby.sh)
- [x] spotify
- [x] telegram
- [ ] [emote](https://snapcraft.io/emote)
- [ ] font-manager
- [ ] lapce 🦀 (vsc)
- [ ] zed 🦀 (vsc)
- [x] [aseprite](https://www.aseprite.org/) (do `Edit > Preferences > General > Screen Scaling: 400%`)
- [x] [krita](https://krita.org/en/download/)
- [ ] steam

### Drivers

- [x] [xencelabs pen tablet](https://www.xencelabs.com/support/download-drivers)

## Extra notes

- Add support for [latest mesa drivers](https://linuxconfig.org/install-and-test-vulkan-on-linux) PPA `bash sudo add-apt-repository ppa:graphics-drivers/ppa`

- Additional video formats `sudo apt-get install ubuntu-restricted-extras libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg`

- Additional build dependencies `pkg-config libssl-dev`

- Dependencies for steam to work `libc6:amd64 libc6:i386 libegl1:amd64 libegl1:i386 libgbm1:amd64 libgbm1:i386 libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 libgl1:amd64 libgl1:i386 steam-libs-amd64:amd64 steam-libs-i386:i386`

## Other dotfiles and tools

- <https://github.com/mhartington/dotfiles>
- <https://github.com/Matsuuu/dotfiles>
- <https://github.com/mhartington/dotfiles/tree/main/config/fonts>
- <https://github.com/adrg/xdg>
