# zsh config

DOTFILES_DIR=$HOME/dotfiles
SETUP_DIR=$DOTFILES_DIR/zsh

# config oh-my-zsh using antigen
source "$SETUP_DIR/antigen.zsh"

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

# initialize Zoxide
eval "$(zoxide init zsh)"

# Preferred editor for local and remote sessions
# use nvim if not ssh otherwise use vim
if [[ -n $SSH_CONNECTION ]]; then
    alias vim='vim'
    export EDITOR='vim'
else
    alias vim='nvim'
    export EDITOR='nvim'
fi

alias lf='\ls -alF' # uses \ls to avoid using ls alias defined below
alias la='\ls -A'
alias l='\ls -CF'

alias ls='exa --long --tree --level=1 --git --classify'
alias lt='exa --long --tree --level=2 --git --classify'

alias clr="tput reset"
alias cdlr="reset && cd && neofetch"

if [[ $(uname) == 'Darwin' ]]; then
    alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
    alias panda="open -a panda"
fi

# handled by nvm-zsh plugin (allows nvm update, but it is not lazy loaded like the custom below)
# source .nvm_setup.zsh

# Show neofetch for some extra points in style
source "$SETUP_DIR/neofetch.sh"
neofetch

# oh-my-gosh prompt
source "$SETUP_DIR/oh-my-posh.zsh"

# ----- unchecked from here ------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# go version manager -> install officially and use go install go@1.18...
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

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
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# devcontainers CLI
# export PATH="$HOME/Library/Application Support/Code/User/globalStorage/ms-vscode-remote.remote-containers/cli-bin":${PATH}

# include Docker symlinks
export PATH=$PATH:$HOME/.docker/bin
