# Setup a new machine 📔

Terminal 📟

- [ ] git
- [ ] curl
- [ ] docker
- [x] zsh
- [x] alias
- [x] oh-my-zsh
- [x] oh-my-posh
- [ ] nerd font
- [x] neofetch
- [ ] tmux
- [ ] fzf
- [ ] nvim
- [ ] gh cli
- [ ] gpg
- [x] nvm
- [ ] go
- [ ] rust
- [ ] python

Applications 🖥️

- [x] alacritty
- [ ] vscode
- [ ] break-timer
- [ ] chrome
- [ ] nordpass
- [ ] nordvpn
- [ ] sublime
- [ ] hyper
- [ ] tabby
- [ ] iina
- [ ] spotify
- [ ] reeder w/ mas-cli
- [ ] telegram
- [ ] whatsapp
- [ ] discord
- [ ] slack
- [ ] clocker

Darwin only 🍏

- [ ] xcode CLI tools
- [x] brew
- [x] brew bundle
- [ ] sudo-touchid
- [ ] whalebrew
- [ ] tgpro
- [ ] parallels

Rustacean 🦀

- [ ] nushell
- [ ] starship
- [ ] zellij
- [ ] exa
- [ ] zoxide
- [ ] fnm
- [ ] lapce
- [ ] zed

## Old step-by-step guide

### Terminal

**Tabby**, most features but slow<https://tabby.sh/>
**Alacritty**, fast and efficient but basic <https://github.com/alacritty/alacritty#configuration>
**Hyper**, beautiful but somehow basic <https://hyper.is/>

#### Oh my zsh

Install zsh with `sudo apt install zsh` and then oh my zsh, <https://ohmyz.sh/#install>

Configured w/ [dotfiles](https://github.com/scristobal/dotfiles)

Make it default with `chsh -s $(which zsh)` reset and check with `echo $SHELL`

#### fzf

Install with `sudo apt install fzf` add to plugins, ie. `plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)` load the changes `source .zshrc`

#### Oh my posh

Install oh posh, either w/ homebrew or manually <https://ohmyposh.dev/docs/installation/linux> and add themes (manually only).

~~then install fonts with `oh-my-posh font install`~~ or using `homebrew/cask-fonts`

need to update `alacritty` to use that font:

- create `touch ~/.config/alacritty/alacritty.yml` and copy <https://github.com/alacritty/alacritty/blob/master/alacritty.yml> there, go to fonts uncomment and change regular font, eg. `family: "MesloLGS Nerd Font Mono"`

then add to `.zshrc` the loader `eval "$(oh-my-posh init zsh --config ~/.poshthemes/catppuccin_mocha.omp.json)"` and reload

#### Exa

`sudo apt install exa` or `brew install exa`

adding alias to `.bashrc` or `.zshrc`

```text
alias ll='exa --long --tree --level=1 --classify'
alias lt='exa --long --tree --level=2 --classify'
alias lf='ls -alF'
alias la='ls -A'
alias l='ls -CF'
```

### Homebrew (macOS)

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

<https://brew.sh>

### Git

`xcode-select --install`

#### Github CLI

<https://github.com/cli/cli/blob/trunk/docs/install_linux.md>

#### Git SSH keys

Preferred with GH CLI `gh auth login` <https://docs.github.com/en/github/authenticating-to-github/checking-for-existing-ssh-keys>

#### Git Config

```bash

git config --global user.name "Samuel Cristobal"
git config --global user.email "el.tobal@gmail.com"
git config --global push.default current
git config --global pull.rebase false
```

### Programing Languages

#### Nodejs

With nvm, install with `brew install nvm` On linux, use the script <https://github.com/nvm-sh/nvm#install--update-script> or (preferably) oh-my-zsh plugin `nvm-zsh` <https://github.com/lukechilds/zsh-nvm> and then install node

```bash
 nvm install node
```

#### Rust

with rustup `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

#### Python

Using [pyenv](https://github.com/pyenv/pyenv-installer) to manage versions, `curl https://pyenv.run | bash`

#### Go

Install Go from source <https://go.dev/doc/install>

> **Warning**
> avoid `gvm` Go versions can be installed using `go install` <https://go.dev/doc/manage-install>

### Editors

#### Visual Studio Code

<https://code.visualstudio.com/> or
<https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions>

#### Neovim

Install with `brew install neovim` and test with `nvim` or `sudo apt install neovim` on Debian/Ubuntu

Edit `.zshrc` with `nvim .zshrc` and add

```bash
alias vim='nvim'
export EDITOR='nvim'
```

maybe there is something like

```bash

  if [[ -n $SSH_CONNECTION ]]; then
      alias vim='vim'
    export EDITOR='vim'
  else
    alias vim='nvim'
      export EDITOR='mvim'
```

reload with `source .zshrc` and now neovim can be launched with just `vim`

go into Vim with `vim` and tipe `: help vimrc` locate `init.vim` file, in macos is `~/.config/nvim/init.vim` so create if does not exist

```bash
mkdir -p .config/nvim
nvim ~/.config/nvim/init.vim
```

add the following

```vim
syntax on
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch
```

Install plugins following <https://github.com/junegunn/vim-plug> basically create an autoload folder `mkdir ./.config/nvim/autoload` and put the `plug.vim` file inside with `curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o plug.vim`

From within `vim` edit `init.vim` with `:e $MYVIMRC` and add this at the bottom:

```vim
call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim'
Plug 'vim-airline/vim-airline'

call plug#end()
```

then run `:source $MYVIMRC` to reload and then `:PlungInstall` to install the plugins.

Again edit `init.vim` with `:e $MYVIMRC` and add `call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })` at the end, and source the file again `:e $MYVIMRC`

Alternatively do the other way around, use the whole `init.vim` and then call first `:PlugInstall` followed by `:source $MYVIMRC` (problem to avoid is part of the file fails if plug ins are not installed already)

> <https://medium.com/@yanglyu5201/neovim-setup-for-golang-programming-68ebf59336d9>

#### Sublime

form terminal

```bash
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/.
```

then launch it with `subl` from terminal

### Docker

<https://www.docker.com/products/docker-desktop>

### Break Timer

<https://github.com/tom-james-watson/breaktimer-app>

### Background

<www.unsplash.com>

### Chrome

<https://github.com/iamadamdev/bypass-paywalls-chrome>

### Razer

For Ubuntu <https://polychromatic.app/download/ubuntu/>
For mac <https://github.com/1kc/razer-macos>

### Ubuntu only

#### Fonts

`sudo apt install font-manager`

#### Extensions

`sudo apt install chrome-gnome-shell`

<https://extensions.gnome.org/>
<https://extensions.gnome.org/extension/1319/gsconnect/>
<https://extensions.gnome.org/extension/1160/dash-to-panel/>

`sudo apt install gnome-shell-extension-prefs`
`sudo apt install gnome-tweaks`

List of extensions:

<https://github.com/home-sweet-gnome/dash-to-panel>
<https://gitlab.com/jenslody/gnome-shell-extension-panel-osd>
<https://extensions.gnome.org/extension/906/sound-output-device-chooser/>
<https://github.com/GSConnect/gnome-shell-extension-gsconnect/wiki>

#### Theme

Install <https://extensions.gnome.org/extension/19/user-themes/> and <https://extensions.gnome.org/extension/3019/user-themes-x/>

Theme:
Sweet-Ambar <https://www.gnome-look.org/p/1253385/>

To install themes, create a `.themes` dir in `$HOME` and copy uncompressed folder. more <https://itsfoss.com/install-switch-themes-gnome-shell>

#### Emote

Emoji keyboard for ubuntu <https://snapcraft.io/install/emote/ubuntu>

#### Spotify

<https://www.spotify.com/us/download/linux/>

#### kernels

<https://github.com/bkw777/mainline>

#### NVIDIA / Vulkan

add support for latest mesa drivers PPA: `sudo add-apt-repository ppa:graphics-drivers/ppa` got it from <https://linuxconfig.org/install-and-test-vulkan-on-linux>

#### Video formats

```bash
sudo apt-get install ubuntu-restricted-extras

sudo apt-get install libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg
```

#### Razer stuff

disable secure boot -> bios with `F1` or `DEL`

```text
sudo add-apt-repository ppa:openrazer/stable
sudo apt update
sudo apt install openrazer-meta
```

`sudo gpasswd -a $USER plugdev`

```text
sudo add-apt-repository ppa:polychromatic/stable
sudo apt update
sudo apt install polychromatic
```
