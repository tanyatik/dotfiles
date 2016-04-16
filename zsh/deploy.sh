#!/usr/bin/env sh
set -e

# Installing oh-my-zsh
debugline 'Installing oh-my-zsh...'
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    curl -L http://install.ohmyz.sh | sh
fi

DIR=$(pwd)

# Adding new .zshrc
if [ $COPY -eq 1 ]; then
    debugline 'Copying new .zshrc...'
    cp "$DIR/zsh/zshrc.sh" "$HOME/.zshrc"
else
    debugline 'Soft-linking new .zshrc...'
    cp "$DIR/zsh/zshrc.sh" "$HOME/.zshrc"
fi

# Adding tmux.conf if necessary
if [ $USE_TMUX -eq 1 ]; then
    debugline 'Adding tmux...'
    cp "$DIR/zsh/tmux.conf" "${HOME}/.tmux.conf"
    cat "$DIR/zsh/add_tmux.sh" >> "${HOME}/.zshrc"
fi

# Adding .zprofile
debugline 'Adding .zprofile...'
cp "$DIR/zsh/zprofile.sh" "$HOME/.zprofile"

