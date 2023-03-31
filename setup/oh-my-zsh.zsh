# oh-my-zsh config using antigen
# aditional options https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template

if [[ ! -f "$HOME/antigen.zsh" ]]
then
    echo "antigen not found, installing"
    curl -L git.io/antigen > "$HOME"/antigen.zsh
fi

source $HOME/antigen.zsh

antigen use oh-my-zsh

# plugins
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle z
antigen bundle lukechilds/zsh-nvm

# OS dependant
case $(uname) in
  Darwin)
    # empty
    antigen bundle osx
  ;;
  Linux)
    # empty
  ;;
esac

# Set the theme
antigen theme theunraveler

# end of antigen config
antigen apply

