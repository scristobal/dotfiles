RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

FOUND="${GREEN}found!${NC}"
NOT_FOUND="${RED}not found!${NC}"

# checks if a file exists
check_file() {

    echo -n "Checking for $1... "

    if [ -f "$HOME"/"$1" ]; then
        echo $FOUND
    else
        echo $NOT_FOUND

    fi
}

# checks if a folder exists
check_folder() {

    echo -n "Checking for $1... "

    if [ -d "$HOME"/"$1" ]; then
        echo $FOUND
    else
        echo $NOT_FOUND
    fi
}
# checks is a single command is installed
check_command() {

    echo -n "Checking for $1... "
    if command -v $1 >/dev/null 2>&1; then
        echo $FOUND
    else
        echo $NOT_FOUND
    fi
}

# checks if a list of commands are installed
check_commands() {
    for i in "$@"; do
        check_command $i
    done
}

check_file antigen.zsh
check_folder .posththemes
check_commands git alacritty zoxide exa nvim code neofetch tmux fzf pyenv nvm
