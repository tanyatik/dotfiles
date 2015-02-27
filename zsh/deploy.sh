#!/usr/bin/env sh
set -e

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    curl -L http://install.ohmyz.sh | sh
fi

DIR="$(pwd)"
echo $DIR
echo $HOME

cp "$DIR/zsh/zshrc.sh" "$HOME/.zshrc"
cp "$DIR/zsh/zprofile.sh" "$HOME/.zprofile"

