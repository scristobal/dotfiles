# Setup a new machine 📔

## Homebrew (macOS)

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

 <https://brew.sh>

## Go

Install Go from source <https://go.dev/dl/>,

> **Warning**
> avoid `gvm` Go versions can be installed using `go install`

## vscode

<https://code.visualstudio.com/> or
<https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions>

and fonts from gmail drafts and `sudo apt install font-manager`

## Git

`xcode-select --install`

## Github CLI

<https://github.com/cli/cli/blob/trunk/docs/install_linux.md>

### SSH keys

Preferred with GH CLI `gh auth login`

<https://docs.github.com/en/github/authenticating-to-github/checking-for-existing-ssh-keys>

### Config

```bash

git config --global user.name "Samuel Cristobal"
git config --global user.email "sc@databeacon.aero"
git config --global push.default current
git config --global pull.rebase false
```

## Nodejs

With NVM, <https://github.com/nodesource/distributions/blob/master/README.md#debinstall> or as a oh-my-zsh plugin `nvm-zsh`

and then install node

```bash
 nvm install node
```

## Python

Using [pyenv](https://github.com/pyenv/pyenv-installer) to manage versions, `curl https://pyenv.run | bash`

## Neovim

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

## Docker

<https://www.docker.com/products/docker-desktop>

use script in <https://github.com/databeacon/level5-api/blob/main/scripts/setup-docker.sh>

## Sublime

form terminal

```bash
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/.
```

then launch it with `subl` from terminal

## Terminal

### Tabby

<https://tabby.sh/>

### Alacritty

<https://github.com/alacritty/alacritty#configuration>

### Oh my zsh

Install zsh with `sudo apt install zsh` and then oh my zsh, <https://ohmyz.sh/#install>

Configured w/ [dotfiles](https://github.com/scristobal/dotfiles)

Make it default with `chsh -s $(which zsh)` reset and check with `echo $SHELL`

#### fzf

Install with `sudo apt install fzf` add to plugins, ie.  `plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)` load the changes `source .zshrc`

## Oh my posh

Install oh posh, with homebrew <https://ohmyposh.dev/docs/linux>

Clone repo and add themes,

then install fonts with `oh-my-posh font install`

need to update `alacritty` to use that font:

- create `touch ~/.config/alacritty/alacritty.yml` and copy <https://github.com/alacritty/alacritty/blob/master/alacritty.yml> there, go to fonts uncomment and change regular font, eg.   `family: "MesloLGL Nerd Font"`

reload,whatever

then add to `.zshrc` the loader `eval "$(oh-my-posh init zsh --config ~/.poshthemes/catppuccin_mocha.omp.json)"` and reload `exec zsh`

More on prompt: <https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal>

### Hyper

<https://hyper.is/>

### Exa

`sudo apt install exa` or `brew install exa`

adding alias to `.bashrc` or `.zshrc`

```text
alias ll='exa --long --tree --level=1 --classify'
alias lt='exa --long --tree --level=2 --classify'
alias lf='ls -alF'
alias la='ls -A'
alias l='ls -CF'
```

## NVIDIA / Vulkan

add support for latest mesa drivers PPA: `sudo add-apt-repository ppa:graphics-drivers/ppa` got it from <https://linuxconfig.org/install-and-test-vulkan-on-linux>

## Spotify

<https://www.spotify.com/us/download/linux/>

## Break Timer

<https://github.com/tom-james-watson/breaktimer-app>

## Background

www.unsplash.com

## Chrome

<https://github.com/iamadamdev/bypass-paywalls-chrome>

## Razer

For Ubuntu <https://polychromatic.app/download/ubuntu/>
For mac <https://github.com/1kc/razer-macos>

## Ubuntu only

### Extensions

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

### Theme

Install <https://extensions.gnome.org/extension/19/user-themes/> and <https://extensions.gnome.org/extension/3019/user-themes-x/>

Theme:
Sweet-Ambar <https://www.gnome-look.org/p/1253385/>

To install themes, create a `.themes` dir in `$HOME` and copy uncompressed folder. more <https://itsfoss.com/install-switch-themes-gnome-shell>

### Emote

Emoji keyboard for ubuntu <https://snapcraft.io/install/emote/ubuntu>

### kernels

<https://github.com/bkw777/mainline>

### Video formats

```bash
sudo apt-get install ubuntu-restricted-extras

sudo apt-get install libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg
```

### Razer stuff

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
