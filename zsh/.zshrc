if [ -f "$HOME"/antigen.zsh ]; then
    # workaround for tmux https://github.com/zsh-users/antigen/issues/543
    ANTIGEN_MUTEX=false

    source "$HOME"/antigen.zsh
    antigen init .antigenrc
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

# use exa, alternative to ls if installed
if command -v exa >/dev/null; then
    alias ls='exa --long --tree --level=1 --git --classify --no-permissions --octal-permissions'
    alias lt='exa --long --tree --level=2 --git --classify --no-permissions --octal-permissions'
    alias lm='exa --long --tree --level=3 --git --classify --no-permissions --octal-permissions'
    alias la='ls -la'
fi

# faster and better clear terminal
alias clr="tput reset"
alias cdlr="reset && cd && neofetch"

# vscode shortcut
alias c="code ."

eval "$(starship init zsh)"

source "$HOME"/.zsh/lazy_pyenv.zsh
source "$HOME"/.zsh/lazy_nvm.zsh

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# include Docker symlinks
export PATH=$PATH:$HOME/.adocker/bin

# Playdate SDK and binaries
export PLAYDATE_SDK_PATH="$HOME"/SDKs/PlaydateSDK-2.4.2
export PATH=PLAYDATE_SDK_PATH/bin:$PATH

# Slow but looks nice
eval "neofetch"
