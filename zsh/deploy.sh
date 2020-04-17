#!/usr/bin/env bash
set -e

# Installing oh-my-zsh
debugline 'Installing oh-my-zsh...'
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # This is totally secure...
    curl -L http://install.ohmyz.sh | sh
fi

DIR=$(pwd)

BACKUP_DIR="$HOME/backup/zsh"
CONFIG_PATH="$HOME/.zshrc"
NEW_CONFIG_PATH="$DIR/zsh/zshrc.sh"

backup
copy_or_symlink

# Adding tmux.conf if necessary
if [ $USE_TMUX -eq 1 ]; then
    debugline 'Adding tmux...'
    cp "$DIR/zsh/tmux.conf" "${HOME}/.tmux.conf"

    cat < ${HOME}/.zshrc << END_HEREDOC
if [[ -z "$TMUX" ]]; then
    tmux has-session &> /dev/null
    if [ $? -eq 1 ]; then
      exec tmux new
      exit
    else
      exec tmux attach
      exit
    fi
fi
END_HEREDOC
fi

# Adding .zprofile
debugline 'Adding .zprofile...'
cp "$DIR/zsh/zprofile.sh" "$HOME/.zprofile"

