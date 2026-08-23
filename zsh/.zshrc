# Keep PATH entries unique, including after sourced toolchain scripts modify it.
typeset -U path PATH

# Homebrew setup
if [[ $OSTYPE == darwin* ]] && (( ! $+commands[brew] )); then
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Tool locations
export ZVM_INSTALL="$HOME/.zvm/self"

path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.cargo/bin"
    "$HOME/.zvm/bin"
    "$ZVM_INSTALL"
    "$HOME/go/bin"
    /usr/local/go/bin
    "$HOME/.adocker/bin"
    $path
)

if [[ $OSTYPE == darwin* && -n ${HOMEBREW_PREFIX:-} ]]; then
    path=("$HOMEBREW_PREFIX/opt/libpq/bin" $path)
fi

# Persistent shell history
_history_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
[[ -d $_history_dir ]] || command mkdir -p -- "$_history_dir"

HISTFILE="$_history_dir/history"
HISTSIZE=1000000
SAVEHIST=1000000

setopt \
    EXTENDED_HISTORY \
    HIST_EXPIRE_DUPS_FIRST \
    HIST_FIND_NO_DUPS \
    HIST_IGNORE_ALL_DUPS \
    HIST_IGNORE_DUPS \
    HIST_IGNORE_SPACE \
    HIST_SAVE_NO_DUPS \
    HIST_VERIFY \
    INC_APPEND_HISTORY

unset _history_dir

# antidote zsh plugin manager
if [[ -r /usr/share/zsh-antidote/antidote.zsh ]]; then
    source /usr/share/zsh-antidote/antidote.zsh
elif [[ -r /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
elif [[ -r /usr/local/opt/antidote/share/antidote/antidote.zsh ]]; then
    source /usr/local/opt/antidote/share/antidote/antidote.zsh
fi

if (( $+functions[antidote] )); then
    antidote load "${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
fi

# interactive shell behavior
setopt AUTO_CD
bindkey -v

if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

# Homebrew compiler overrides
if [[ $OSTYPE == darwin* ]]; then
    # Global compiler search paths are disabled to avoid affecting builds that
    # don't intend to use Homebrew libraries and headers.
    # export LIBRARY_PATH="$HOMEBREW_REPOSITORY/lib:$LIBRARY_PATH"
    # export CPATH="$HOMEBREW_REPOSITORY/include:$CPATH"

    # Required to link to openssl 3 instead of mac internal version
    # export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

    # support for x86 brew made explicit
    # remember to use compilation flags ARCHFLAGS="-arch x86_64"
    # alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"

fi

# initialize Zoxide, if available
if (( $+commands[zoxide] )); then
    source <(zoxide init zsh)
fi

# set neovim as default editor
alias n='nvim'
export EDITOR='nvim'
export VISUAL="$EDITOR"

# Built-in help and platform-native file opening.
(( $+aliases[run-help] )) && unalias run-help
autoload -Uz run-help
alias help='run-help'

case "$OSTYPE" in
    darwin*) (( $+commands[open] )) && alias o='open' ;;
    linux*)  (( $+commands[xdg-open] )) && alias o='xdg-open' ;;
esac

# eza is an alternative to ls
alias e="eza -a -l --icons --git"
alias et="eza -a --tree --level=2 --long --icons --git"
alias ett="eza -a --tree --level=3 --long --icons --git"

cx() { cd "$@" && ls; }
alias tg="tv git-repos"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# faster and better clear terminal
alias clr="tput reset"
alias cdlr="reset && cd && fastfetch 2> /dev/null"

# custom prompt
if (( $+commands[starship] )); then
    source <(starship init zsh)
fi

# rust with rustup
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# node with nvm
export NVM_DIR="$HOME/.config/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# playdate SDK
# if [[ $OSTYPE == darwin* ]]; then
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
