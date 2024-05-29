if [ -f "$HOME"/antigen.zsh ]; then
    # workaround for tmux https://github.com/zsh-users/antigen/issues/543
    ANTIGEN_MUTEX=false

    source "$HOME"/antigen.zsh
    antigen init "$HOME"/.antigenrc
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

if command -v fastfetch >/dev/null; then
    alias cdlr="reset && cd && fastfetch"
else
    alias cdlr="reset && cd"
fi

# vscode shortcut
if command -v code >/dev/null; then
    alias c="code ."
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

# Playdate SDK and binaries
export PLAYDATE_SDK_PATH="$HOME"/SDKs/PlaydateSDK-2.4.2
export PATH=PLAYDATE_SDK_PATH/bin:$PATH

# local binaries, eg. exericism CLI
PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# Slow but looks nice
command -v fastfetch >/dev/null 2>&1 && eval "$(fastfetch)"
