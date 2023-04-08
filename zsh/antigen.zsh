# oh-my-zsh config using antigen
# aditional options https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template

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

# Set the theme -> overwritten by oh-my-posh
# antigen theme robbyrussell

# end of antigen config
antigen apply
