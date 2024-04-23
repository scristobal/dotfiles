RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

FOUND="${GREEN}found!${NC}"
NOT_FOUND="${RED}not found!${NC}"

# checks if a list of files exist
check_files() {
    for i in "$@"; do
        echo -n "Checking for $i... "

        if [ -f "$HOME"/"$i" ]; then
            echo $FOUND
        else
            echo $NOT_FOUND
        fi
    done
}

# checks if a list of folders exist
check_folders() {
    for i in "$@"; do
        echo -n "Checking for $i... "

        if [ -d "$HOME"/"$i" ]; then
            echo $FOUND
        else
            echo $NOT_FOUND
        fi
    done
}

# checks if a list of commands are installed
check_commands() {
    for i in "$@"; do
        echo -n "Checking for $i... "

        if command -v $i >/dev/null 2>&1; then
            echo $FOUND
        else
            echo $NOT_FOUND
        fi
    done
}

check_file antigen.zsh
check_folders .config/alacritty/themes/themes/
check_commands stow git alacritty zoxide exa nvim code neofetch tmux fzf pyenv nvm
