# local binaries
PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# antidote zsh plugin manager
if [ -f "/usr/share/zsh-antidote/antidote.zsh" ]; then
    source '/usr/share/zsh-antidote/antidote.zsh'
    antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
fi

# apple specific stuff
if [[ $(uname) == 'Darwin' ]]; then

    # Load Homebrew if /opt/homebrew/bin/brew exists
    if [ -f "$HOMEBREW_REPOSITORY/bin/brew" ]; then
        eval "$($HOMEBREW_REPOSITORY/bin/brew shellenv)"
    fi

    if [ -f  "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh" ]; then
        source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
        antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
    fi

    # On ARM macs the default homebrew installation moved
    # to /opt/homebrew. For meson to be able to find homebrew
    # files you need to set the following environment:
    export PATH=$HOMEBREW_REPOSITORY/bin:$PATH
    export LIBRARY_PATH=$HOMEBREW_REPOSITORY/lib:$LIBRARY_PATH
    export CPATH=$HOMEBREW_REPOSITORY/include:$CPATH

    # Required to link to openssl 3 instead of mac internal version
    # export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

    # support for x86 brew made explicit
    # remember to use compilation flags ARCHFLAGS="-arch x86_64"
    # alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"

    # Sublime editor config requires special, platform-dependant directory
    # SUBLIME_SETTINS="$HOME"/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings
    #
    # if [ ! -L "$SUBLIME_SETTINS" ]; then
    #     ln -s "$HOME/.config/sublime-text/Preferences.sublime-settings" "$SUBLIME_SETTINS"
# local binaries
PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    # fi
    
    # Launch Sublime from terminal with `subl` with `sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/.`
fi

# initialize Zoxide, if available
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Preferred editor for local and remote sessions
# use nvim if not ssh otherwise use vim
if [[ -n $SSH_CONNECTION ]]; then
    alias vim='vim'
    alias n='vim'
    export EDITOR='vim'
else
    alias vim='nvim'
    alias n='nvim'
    export EDITOR='nvim'
fi

alias reload= 'source ~/.zshrc'

# use eza, alternative to ls if installed
if command -v eza >/dev/null; then

    alias ls="eza -l --icons --git -a"
    alias lt="eza --tree --level=2 --long --icons --git"
    alias ltree="eza --tree --level=2  --icons --git"

    # alias ls='eza --long --tree --level=1 --git --classify --no-permissions --octal-permissions'
    # alias lt='eza --long --tree --level=2 --git --classify --no-permissions --octal-permissions'
    # alias lm='eza --long --tree --level=3 --git --classify --no-permissions --octal-permissions'
    # alias la='ls -la'
fi


cx() { cd "$@" && ls; }

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'
# gcp() { 'git clone --depth 1 --recurse-submodules --shallow-submodules $1' }

# faster and better clear terminal
alias clr="tput reset"

# alias ff="aerospace list-windows --all | fzf --bind 'enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort'"

if command -v fastfetch >/dev/null; then
    alias cdlr="reset && cd && fastfetch"
else
    alias cdlr="reset && cd"
fi

# custom  prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"


# Rust with rustup
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Node with nvm
export NVM_DIR="$HOME/.config/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Zig with zvm
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# Go
export PATH=$PATH:/usr/local/go/bin

# Playdate SDK 
if [[ $(uname) == 'Darwin' ]]; then
    export PLAYDATE_SDK_PATH="$HOME"/Developer/PlaydateSDK
else
    #   $ yay -S playdate-sdk
    #   $ mkdir -p "${XDG_DATA_HOME:-"${HOME}/.local/share"}/playdate-sdk"
    export PLAYDATE_SDK_PATH="$HOME"/.local/share/playdate-sdk
fi

export PATH=PLAYDATE_SDK_PATH/bin:$PATH

# Vulkan SDK
export VULKAN_SDK="$HOME/vulkan/1.3.290.0"
[ -s "$VULKAN_SDK/setup-env.sh" ] && \. "$VULKAN_SDK/setup-env.sh"


# emscripten SDK
#   $ yay -S emsdk
#   $ sudo /usr/lib/emsdk/emsdk install latest
#   $ sudo /usr/lib/emsdk/emsdk activate latest
if [ -f "/usr/lib/emsdk/emsdk_env.sh" ]; then
    export EMSDK_QUIET=1  
    source "/usr/lib/emsdk/emsdk_env.sh" 
fi

# Docker
export PATH=$PATH:$HOME/.adocker/bin

# Slow but looks nice
command -v fastfetch >/dev/null 2>&1 && fastfetch
