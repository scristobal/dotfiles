# oh-my-posh themes download

THEMES_DIR=$HOME/.poshthemes

if ! command -v oh-my-posh >/dev/null 2>&1; then

    echo "Oh my Posh not installed. Installing..."

    if [[ $(uname) == 'Darwin' ]] && [[ $(uname -m) == 'arm64' ]]; then

        brew install jandedobbeleer/oh-my-posh/oh-my-posh

    elif [[ $(uname) == 'Linux' ]] && [[ $(uname -m) == 'x86_64' ]]; then

        BIN_PATH=/usr/local/bin/oh-my-posh

        sudo curl -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -o $BIN_PATH
        sudo chmod +x $BIN_PATH

    fi

fi

if [[ ! -d "$THEMES_DIR" ]] || [ -z "$(\ls -A $THEMES_DIR)" ]; then
    echo "Oh my Posh themes not found, downloading..."

    mkdir $THEMES_DIR
    curl -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip >$THEMES_DIR/themes.zip
    unzip $THEMES_DIR/themes.zip -d $THEMES_DIR
    chmod u+rw $THEMES_DIR/*.omp.*
    rm $THEMES_DIR/themes.zip

fi
