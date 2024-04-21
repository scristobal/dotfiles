if [ -f "$HOME"/antigen.zsh ]; then
    source "$HOME"/antigen.zsh
    antigen init .antigenrc
fi

if [[ $(uname) == 'Darwin' ]]; then
    # On ARM macs the default homebrew installation moved
    # to /opt/homebrew. For meson to be able to find homebrew
    # files you need to set the following environment:
    export PATH=$HOMEBREW_REPOSITORY/bin:$PATH
    export LIBRARY_PATH=$HOMEBREW_REPOSITORY/lib:$LIBRARY_PATH
    export CPATH=$HOMEBREW_REPOSITORY/include:$CPATH

    # Required to link to openssl 3 instead of mac internal version
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

    # support for x86 brew made explicit
    alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"

    # remember to use compilation flags ARCHFLAGS="-arch x86_64"

    # Sublime editor config requires special, platform-dependant directory
    SUBLIME_SETTINS="$HOME"/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings
    if [ ! -f SUBLIME_SETTINS]; then
        ln -s "$HOME/.config/sublime-text/Preferences.sublime-settings" SUBLIME_SETTINS
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

source lazy_pyenv.zsh
source lazy_nvm.zsh

# include Docker symlinks
export PATH=$PATH:$HOME/.adocker/bin

# Optional
export PLAYDATE_SDK_PATH="$HOME/Developer/PlaydateSDK"

# Slow but looks nice
eval "neofetch"
