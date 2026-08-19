# antidote zsh plugin manager
if [ -f "/usr/share/zsh-antidote/antidote.zsh" ]; then
    source '/usr/share/zsh-antidote/antidote.zsh'
    antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
else 
    export HISTSIZE=1000000000
    export SAVEHIST=$HISTSIZE
    setopt EXTENDED_HISTORY
    setopt autocd
    autoload -U compinit; compinit
    source <(fzf --zsh)
    set -o vi
fi
    
# fix for backspace in vi mode
bindkey -v '^?' backward-delete-char

# brew quircks
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

    # psql
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

# 1Password SSH signing for git commits
if [[ $(uname) == 'Darwin' ]]; then
    export GIT_CONFIG_COUNT=1
    export GIT_CONFIG_KEY_0="gpg.ssh.program"
    export GIT_CONFIG_VALUE_0="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
else
    export GIT_CONFIG_COUNT=1
    export GIT_CONFIG_KEY_0="gpg.ssh.program"
    export GIT_CONFIG_VALUE_0="/opt/1Password/op-ssh-sign"
fi

# initialize Zoxide, if available
source <(zoxide init zsh) 2> /dev/null

# set neovim as default editor
alias n='nvim'
export EDITOR='nvim'

# eza is an alternative to ls
alias e="eza -a -l --icons --git -a"
alias et="eza -a --tree --level=2 --long --icons --git"
alias ett="eza -a --tree --level=3 --long --icons --git"
alias er= "eza -a --tree --level=2  --icons --git"
alias err="eza -a --tree --level=3  --icons --git"

cx() { cd "$@" && ls; }
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# faster and better clear terminal
alias clr="tput reset"
alias cdlr="reset && cd && fastfetch 2> /dev/null"

# custom prompt
source <(starship init zsh) 2> /dev/null

# rust with rustup
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
[ -s "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"

# node with nvm
export NVM_DIR="$HOME/.config/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# zig with zvm
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# go
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# playdate SDK
# if [[ $(uname) == 'Darwin' ]]; then
#     export PLAYDATE_SDK_PATH="$HOME"/Developer/PlaydateSDK
# else
#     #   $ paru -S playdate-sdk
#     #   $ mkdir -p "${XDG_DATA_HOME:-"${HOME}/.local/share"}/playdate-sdk"
#     export PLAYDATE_SDK_PATH="$HOME"/.local/share/playdate-sdk
# fi
#
# export PATH="$PLAYDATE_SDK_PATH/bin:$PATH"

# vulkan SDK
# export VULKAN_SDK="$HOME/vulkan/1.3.290.0"
# [ -s "$VULKAN_SDK/setup-env.sh" ] && \. "$VULKAN_SDK/setup-env.sh"

# emscripten SDK
#   $ yay -S emsdk
#   $ sudo /usr/lib/emsdk/emsdk install latest
#   $ sudo /usr/lib/emsdk/emsdk activate latest
# if [ -f "/usr/lib/emsdk/emsdk_env.sh" ]; then
#     export EMSDK_QUIET=1
#     source "/usr/lib/emsdk/emsdk_env.sh"
# fi

# docker
export PATH=$PATH:$HOME/.adocker/bin

# local binaries
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# slow but looks nice
fastfetch 2> /dev/null
