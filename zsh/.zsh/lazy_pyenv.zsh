# script to lazy load pyenv

lazypyenv() {
    unset -f pyenv

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/shims:$PATH"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
}

pyenv() {
    echo "loading pyenv..."

    lazypyenv
    pyenv $@
}
