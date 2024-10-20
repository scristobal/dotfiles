if [ -f "/usr/share/zsh-antidote/antidote.zsh" ]; then
    source '/usr/share/zsh-antidote/antidote.zsh'
    antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
fi

if [[ $(uname) == 'Darwin' ]]; then

    # Load Homebrew if /opt/homebrew/bin/brew exists
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    alias brew="sudo -u samu brew"

    # On ARM macs the default homebrew installation moved
    # to /opt/homebrew. For meson to be able to find homebrew
    # files you need to set the following environment:
    export PATH=$HOMEBREW_REPOSITORY/bin:$PATH
    export LIBRARY_PATH=$HOMEBREW_REPOSITORY/lib:$LIBRARY_PATH
    export CPATH=$HOMEBREW_REPOSITORY/include:$CPATH

    # Required to link to openssl 3 instead of mac internal version
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

    # support for x86 brew made explicit
    # remember to use compilation flags ARCHFLAGS="-arch x86_64"
    alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"

    # Sublime editor config requires special, platform-dependant directory
    SUBLIME_SETTINS="$HOME"/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings

    if [ ! -L "$SUBLIME_SETTINS" ]; then
        ln -s "$HOME/.config/sublime-text/Preferences.sublime-settings" "$SUBLIME_SETTINS"
    fi

    # Launch Sublime from terminal with `subl` with `sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/.`
fi

# initialize Zoxide, if available
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Preferred editor for local and remote sessions
# use nvim if not ssh otherwise use vim
if [[ -n $SSH_CONNECTION ]]; then
    alias vim='vim'
    export EDITOR='vim'
else
    alias vim='nvim'
    export EDITOR='nvim'
fi

# use eza, alternative to ls if installed
if command -v eza >/dev/null; then
    alias ls='eza --long --tree --level=1 --git --classify --no-permissions --octal-permissions'
    alias lt='eza --long --tree --level=2 --git --classify --no-permissions --octal-permissions'
    alias lm='eza --long --tree --level=3 --git --classify --no-permissions --octal-permissions'
    alias la='ls -la'
fi

# faster and better clear terminal
alias clr="tput reset"

if command -v fastfetch >/dev/null; then
    alias cdlr="reset && cd && fastfetch"
else
    alias cdlr="reset && cd"
fi

# neovim shortcut
if command -v nvim >/dev/null; then
    alias n="nvim ."
fi

# custom  prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Rust with rustup
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Python with pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

# Node with nvm
export NVM_DIR="$HOME/.config/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Zig with ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# Go
export PATH=$PATH:/usr/local/go/bin

# Docker
export PATH=$PATH:$HOME/.adocker/bin

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

# local binaries
PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# emscripten SDK
#   $ yay -S emsdk
#   $ sudo /usr/lib/emsdk/emsdk install latest
#   $ sudo /usr/lib/emsdk/emsdk activate latest
if [ -f "/usr/lib/emsdk/emsdk_env.sh" ]; then
    export EMSDK_QUIET=1  
    source "/usr/lib/emsdk/emsdk_env.sh" 
fi

# Slow but looks nice
command -v fastfetch >/dev/null 2>&1 && fastfetch
