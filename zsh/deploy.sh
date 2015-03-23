#!/usr/bin/env sh
set -e

echo "use tmux $USE_TMUX"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    curl -L http://install.ohmyz.sh | sh
fi

DIR="$(pwd)"

cp "$DIR/zsh/zshrc.sh" "$HOME/.zshrc"

if [ $USE_TMUX -eq 1 ]; then
    [ $VERBOSE -eq 1 ] && printf 'Adding Tmux\n'
    cat $DIR/zsh/add_tmux.sh >> "${HOME}/.zshrc"
fi

cp "$DIR/zsh/zprofile.sh" "$HOME/.zprofile"

