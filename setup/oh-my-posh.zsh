# oh-my-posh setup and config

BIN_PATH=/usr/local/bin/oh-my-posh
THEMES_DIR=$HOME/.poshthemes
THEME=emodipt-extend

if [[ ! -f "$BIN_PATH" ]] then
    if [[ $(uname) == 'Darwin' ]] && [[ $(uname -m) == 'arm64' ]]; then
        echo "Oh my Posh not found, installing on Darwin arm64"
        sudo curl -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-darwin-arm64 -o $BIN_PATH

    elif  [[ $(uname) == 'Linux' ]] && [[ $(uname -m) == 'x86_64' ]]; then
        echo "Oh my Posh not found, installing on Linux x86_64"
        sudo curl -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64  -o $BIN_PATH

    fi

    sudo chmod +x $INSTALL_DIR
fi


if [[ ! -d "$THEMES_DIR" ]] || [ -z "$(\ls -A $THEMES_DIR)" ]; then
    echo "Oh my Posh themes not found, downloading..."

    mkdir $THEMES_DIR
    curl -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip > $THEMES_DIR/themes.zip
    unzip $THEMES_DIR/themes.zip -d $THEMES_DIR/.poshthemes
    chmod u+rw $THEMES_DIR/*.omp.*
    rm $THEMES_DIR/themes.zip

fi



eval "$(oh-my-posh init zsh --config $THEMES_DIR/$THEME.omp.json)"