RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

FOUND="${GREEN}found!${NC}"
NOT_FOUND="${RED}not found!${NC}"

echo -n "Checking for antigen... "

if [ -f "$HOME"/antigen.zsh ]; then
    echo $FOUND
else
    echo $NOT_FOUND
fi

echo -n "Checking for oh-my-posh... "

if [ -d "$HOME"/.poshthemes ]; then
    echo $FOUND
else
    echo $NOT_FOUND
fi

# checks is a single command is installed
check_command() {

    FOUND="${GREEN}found!${NC}"
    NOT_FOUND="${RED}not found!${NC}"

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

check_commands git alacritty zoxide exa nvim code neofetch tmux pyenv nvm
