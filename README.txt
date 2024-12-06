Fantastic `dotfiles` and where to find them

What is included/recommended?

- zshm `chsh -s $(which zsh)`
- nvim
- git
- gh, (github cli)
- gnupg
- stow
- curl
- docker
- oh-my-zsh
- nerd fonts
- tmux
- fzf
- jq
- neofetch
- bat, https://github.com/sharkdp/bat?tab=readme-ov-file#installation 🦀 (cat++)
- tailspin, https://github.com/bensadeh/tailspin?tab=readme-ov-file#installing 🦀
- curlie, https://github.com/rs/curlie?tab=readme-ov-file#install 🦫 (curl++)
- glow, https://github.com/charmbracelet/glow?tab=readme-ov-file#installation 🦫 (render `.md` files)
- btop, https://github.com/aristocratos/btop?tab=readme-ov-file#installation (top+++)
- ncdu, https://code.blicky.net/yorhel/ncdu/ 🦎 (du+++)
- fx, https://fx.wtf/install#installation 🦫 (jq++)
- broot, https://github.com/Canop/broot 🦀 (finder)
- ncspot, https://github.com/hrkfdn/ncspot?tab=readme-ov-file#installation 🦀 (spotify)
- monolith, https://github.com/y2z/monolith (save HTML single file)
- yt-dlp, (youtube downloader)
- topgrade, https://github.com/topgrade-rs/topgrade?tab=readme-ov-file#installation (automatic tool upgrades, apparently)
- nushell, https://www.nushell.sh/book/installation.html#build-using-crates-io 🦀 (shell)
- starship, 🦀 (oh-my-posh)
- zellij, 🦀 (tmux)
- eza, 🦀 (ls++)
- zoxide, 🦀 (cd++)
- fnm, 🦀 (nvm)
- dust, https://github.com/bootandy/dust 🦀 (du+++)
- ncdu, (du-tui++++)
- ripgrep, https://github.com/BurntSushi/ripgrep 🦀 (grep++)
- fd, https://github.com/sharkdp/fd 🦀 (find++)
- skim, https://github.com/lotabout/skim?tab=readme-ov-file 🦀 (fzf)
- hyperfine, https://github.com/sharkdp/hyperfine?tab=readme-ov-file#installation 🦀 (time++)
- oha, https://github.com/hatoo/oha 🦀 (hey https://github.com/rakyll/hey)
- difft, https://difftastic.wilfred.me.uk/installation.html 🦀 (diff++)
- tealdeer, https://github.com/dbrgn/tealdeer?ref=itsfoss.com 🦀 (tldr)
- procs, https://github.com/dalance/procs 🦀 (ps++)
- macchina, https://github.com/Macchina-CLI/macchina/wiki/Installation 🦀 (neofetch)
- ouch, https://github.com/ouch-org/ouch?tab=readme-ov-file#installation 🦀 (de/compress)
- exercisim, CLI https://exercism.org/cli-walkthrough
- ncu, https://www.npmjs.com/package/npm-check-updates

Programing

- nvm, https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
- rustup, https://rustup.rs/ 🦀
- zigup, https://github.com/marler8997/zigup (or zvm https://www.zvm.app/
- pyenv, https://github.com/pyenv/pyenv?tab=readme-ov-file#installation) + poetry https://python-poetry.org/docs/#installation
- go, https://go.dev/doc/install#extra_versions
- Lua, https://www.lua.org/download.html
- Playdate SDK, (https://play.date/dev/) + Mirror (https://play.date/mirror/) + project template (https://github.com/scristobal/playdate-c-api-experiments)
- cmake, ninja and meson
- gfortran, https://fortran-lang.org/learn/os_setup/install_gfortran/#linux

Applications

- alacritty (https://alacritty.org/) + themes (https://github.com/alacritty/alacritty-theme)
- vscode
- break-timer (https://github.com/tom-james-watson/breaktimer-app)
- firefox + nightly
- chromium (https://snapcraft.io/chromium) + canary
- proton pass (https://proton.me)
- proton vpn (https://protonvpn.com/support/official-ubuntu-vpn-setup/)
- sublime
- hyper (https://hyper.is/)
- tabby (https://tabby.sh)
- spotify
- telegram
- emote (https://snapcraft.io/emote)
- font-manager
- lapce 🦀 (vsc)
- zed 🦀 (vsc)
- aseprite (https://www.aseprite.org/)
- krita (https://krita.org/en/download/)
- steam (see notes section)

Drivers

- xencelabs pen tablet https://www.xencelabs.com/support/download-drivers)

Notes

- Add support for latest mesa drivers https://linuxconfig.org/install-and-test-vulkan-on-linux) PPA `bash sudo add-apt-repository ppa:graphics-drivers/ppa`
- Additional video formats `sudo apt-get install ubuntu-restricted-extras libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg`
- Additional build dependencies `pkg-config libssl-dev`
- Dependencies for steam to work `libc6:amd64 libc6:i386 libegl1:amd64 libegl1:i386 libgbm1:amd64 libgbm1:i386 libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 libgl1:amd64 libgl1:i386 steam-libs-amd64:amd64 steam-libs-i386:i386 libsdl2-dev`
- `libfuse2` required for some old AppImages
- Makedeb https://docs.makedeb.org/prebuilt-mpr/getting-started/#setting-up-the-repository)
- Aseprite needs manual scaling (do `Edit > Preferences > General > Screen Scaling: 400%`)

Setting up a Mac

System Settings

Siri
- Toggle Siri off
- Click “About Siri dict…” disable all one-by-one

Spotlight
- Toggle all checks off
- Click on “Search Privacy”
    - Add “Macintosh HD” and any other drives

Keyboard
- Crack Key repeat and Key delay to max right
- Open “Keyboard Shortcuts”
    - Remove both “Spotlight” shortcuts
    - In “Launchpad & Dock” set “Show launchpad” to cmd+space
- Text input
    - Remove all options under “Text replacement”

Mouse
- Set “Secondary click” to “Click right side”
- Toggle “Smart Zoom” on
- Advance
    - Toggle “Pointer acceleration” off
- Click on “More gestures”
    - Set “Swipe between pages” to “Scroll left or right with one finger”

Displays
- Toggle “Automatically adjust brightness” off
- Toggle “True Tone” off

Desktop & Dock
- Toggle “Show indicators for open applications” off
- Toggle “Show suggested and recent apps in Dock” off
- Disable “Show items” on desktop
- Toggle “Minimize windows into application icon” on
- Toggle “Automatically hide and show the Dock” on
- Toggle “Animate opening applications” off

Accessibility
- Pointer Control -> Trackpad Options -> Use trackpad for dragging -> Draggind Style -> Three Finger Drag
- (optional) Reduce motion
- (optional) Reduce transparency

Control Center
- Set Bluetooth “Show in Menu Bar”
- Set Sound to “Always Show in Menu Bar”
- Set Spotlight “Don’t Show in Menu Bar”
- Set Siri “Don’t Show in Menu Bar”
- (oled) Set Automatically hide and show the menu bar to “Always”

Wallpaper
- (oled) Choose black color

Install TinkerTool and configure with

Finder
- Toggle “Animate opening …” off
- Toggle “Animate selecting …” off
- Toggle “Don’t create hidden DS_Store …” on

Dock
- Toggle “Disable animation …” on
- Toggle “Disable delay …” on

Launchpad
- Toggle “Disable fade-in …” on
- Toggle “Disable fade-out ...” on
- Toggle “Disable animation when …” on


Install brew from https://brew.sh set in PATH as indicated.

Normal brew installs

- pkg-config
- llvm
- stow
- antidote
- neovim
- eza
- zoxide
- fzf
- fastfetch
- starship
- tmux
- gnupg
- aws-cli
- terraform, needs a tap https://developer.hashicorp.com/terraform/install?product_intent=terraform
- terragrunt
- sops
- just
- protobuf
- wget
- curl
- grcurl
- jq
- wasm3
- ncspot
- yt-dlp
- lunar
- p7zip
- ncdu

Casks

- proton pass
- alt-tab
- sublime-text
- breaktimer
- tabby, https://tabby.sh


Manual installation

- Nerd Fonts (Mononoki, JetBrainsMono), https://www.nerdfonts.com/font-downloads
- Alacrity, https://alacritty.org
- Rust, https://www.rust-lang.org/tools/install
- Go, https://golang.google.cn/learn/#selected-tutorials
- Zvm, https://www.zvm.app/guides/install-zvm/
- Nvm, https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
- Pyenv, https://github.com/pyenv/pyenv-installer?tab=readme-ov-file#install
- Docker, https://docs.docker.com/desktop/setup/install/mac-install/#install-and-run-docker-desktop-on-mac
- TG Pro, https://www.tunabellysoftware.com/tgpro/#  license key on proton (or gmail
- Visual Studio Code, https://code.visualstudio.com/download
- Proton Pass for Safari, https://apps.apple.com/es/app/proton-pass-for-safari/id6502835663?l=en-GB&mt=12
- NordPass for Safari, https://apps.apple.com/es/app/nordpass-for-safari/id6443917910?l=en-GB&mt=12
- Spotify, https://www.spotify.com/at/download/mac/
- Reeder Classic, https://apps.apple.com/es/app/reeder-classic/id1529448980
- Chrome, https://support.google.com/chrome/answer/95346?hl=en&co=GENIE.Platform%3DDesktop#zippy=%2Cmac
- TinkerTool, https://www.bresink.biz/download2.php?ln=1&dl=TinkerTool
- Wipr 2, https://apps.apple.com/es/app/wipr-2/id1662217862?l=en-GB
- Telegram, https://desktop.telegram.org
- Whatsapp, https://www.whatsapp.com
- Slack, https://slack.com/intl/en-gb/downloads/mac
- vivid, https://app.gumroad.com/d/bb9b38cb3c8542ff60e640e69e764a4c license key on proton (or gmail)
- mos, https://mos.caldis.me
- PlayDate SDK, https://play.date/dev/
- Vulkan SDK, https://vulkan.lunarg.com/sdk/home#mac
- Emscripten, https://emscripten.org/docs/getting_started/downloads.html
- Parallels,


Other dotfiles and tools

- https://github.com/mhartington/dotfiles
- https://github.com/Matsuuu/dotfiles
- https://github.com/ranisalt/dotfiles
- https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages
- https://github.com/mhartington/dotfiles/tree/main/config/fonts
- https://github.com/adrg/xdg
- https://github.com/MikeMcQuaid/strap
