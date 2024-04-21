# script to lazy load nvm
lazynvm() {
    unset -f nvm node npm

    export NVM_DIR="$HOME/.nvm"

    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source $NVM_DIR/nvm.sh # This loads nvm
    else
        echo "nvm not found"
        # echo "installing..."
        # git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        # cd "$NVM_DIR"
        # git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    fi
}

nvm() {
    echo "loading nvm..."

    lazynvm
    nvm $@
}

node() {
    echo "loading nvm..."

    lazynvm
    node $@
}

npm() {
    echo "loading nvm..."

    lazynvm
    npm $@
}
