
NEOFETCH_DIR="$HOME/.neofetch"

if [[ ! -d "$NEOFETCH_DIR" ]] || [ -z "$(\ls -A $NEOFETCH_DIR)" ]; then
    echo "Neofetch not found, installing..."
    git clone https://github.com/dylanaraps/neofetch "$NEOFETCH_DIR"
    cd "$NEOFETCH_DIR"
    git checkout `git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1)`
    sudo make PREFIX=/usr/local install
    cd ..
fi


alias neofetch='$HOME/.neofetch/neofetch'


"$HOME/.neofetch/neofetch"