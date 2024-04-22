# script to lazy load nvm
lazynvm() {
    unset -f nvm node npm

    export NVM_DIR="$HOME/.config/nvm"

    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

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
