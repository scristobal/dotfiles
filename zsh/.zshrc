# oh-my-zsh config using antigen, if available
if [[ -f $HOME/antigen.zsh ]]; then
    source "$HOME"/antigen.zsh

    # aditional options https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
    antigen use oh-my-zsh

    # plugins
    antigen bundle git
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle z
    antigen bundle lukechilds/zsh-nvm
    antigen bundle fzf

    # OS dependant
    case $(uname) in
    Darwin)
        # empty
        antigen bundle osx
        ;;
    Linux)
        # empty
        ;;
    esac

    # Set the theme
    # antigen theme robbyrussell <-- overwritten by oh-my-posh

    # end of antigen config
    antigen apply
fi

if [[ $(uname) == 'Darwin' ]]; then
    # On ARM macs the default homebrew installation moved
    # to /opt/homebrew. For meson to be able to find homebrew
    # files you need to set the following environment:
    export PATH=$HOMEBREW_REPOSITORY/bin:$PATH
    export LIBRARY_PATH=$HOMEBREW_REPOSITORY/lib:$LIBRARY_PATH
    export CPATH=$HOMEBREW_REPOSITORY/include:$CPATH

    # Compilation flags
    # export ARCHFLAGS="-arch x86_64"
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

if command -v exa >/dev/null; then
    alias ls='exa --long --tree --level=1 --git --classify'
    alias lt='exa --long --tree --level=2 --git --classify'
    alias la='ls -la'
fi

alias clr="tput reset"
alias cdlr="reset && cd && neofetch"

alias c="code ."

if [[ $(uname) == 'Darwin' ]]; then
    alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
fi

if [ ! -f "$HOME"/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings ]; then
    ln -s "$HOME/.config/sublime-text/Preferences.sublime-settings" "$HOME/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings"
fi

{ [ ! -d "$NEOFETCH_DIR" ] || [ -z "$(\ls -A "$NEOFETCH_DIR")" ]; } && neofetch

POSH_THEME=amro
[ -f "$HOME"/.poshthemes/$POSH_THEME.omp.json ] && eval "$(oh-my-posh init zsh --config "$HOME"/.poshthemes/$POSH_THEME.omp.json)"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# node version manager, is installed with nvm-zsh

# go version manager -> install officially and use go install go@1.18...

# include Docker symlinks
export PATH=$PATH:$HOME/.adocker/bin

export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

export PLAYDATE_SDK_PATH="$HOME/Developer/PlaydateSDK"
