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
