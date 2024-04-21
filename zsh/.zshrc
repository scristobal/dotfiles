if [ -f "$HOME"/antigen.zsh ]; then
    source "$HOME"/antigen.zsh
    antigen init "$HOME"/.antigenrc
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

    # Required to link to openssl 3 instead of mac internal version
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"
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

# support for x86 brew made explicit
if [[ $(uname) == 'Darwin' ]]; then
    alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
fi

# Sublime editor config requires special, platform-dependant directory
if [[ $(uname) == 'Darwin' ]] && [ ! -f "$HOME"/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings ]; then
    ln -s "$HOME/.config/sublime-text/Preferences.sublime-settings" "$HOME/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings"
fi

POSH_THEME=easy-term # amro
[ -f "$HOME"/.poshthemes/$POSH_THEME.omp.json ] && eval "$(oh-my-posh init zsh --config "$HOME"/.poshthemes/$POSH_THEME.omp.json)"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# Python version manager
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/shims:$PATH"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# # Nodejs version manager
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR"/nvm.sh

# # Go and Rust do not require version managers

# # include Docker symlinks
# export PATH=$PATH:$HOME/.adocker/bin

# # Optional
# export PLAYDATE_SDK_PATH="$HOME/Developer/PlaydateSDK"

# Slow but looks nice
eval "neofetch"
