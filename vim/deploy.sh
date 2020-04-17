#!/usr/bin/env bash
set -e

DIR="$(pwd)"

BACKUP_DIR="$HOME/backold-vim-config"
CONFIG_PATH="$HOME/.vimrc"
NEW_CONFIG_PATH="$DIR/vim/vimrc.vim"

# Backup old vim files
backup

if [ $USE_YCM -eq 0 ]; then
    debugline 'Turn off YCM...'
    sed -i -e "s/Plugin 'Valloric\/YouCompleteMe'/"'"'" Plugin 'Valloric\/YouCompleteMe'/" $DIR/vim/vimrc.vim
fi

# Copying new .vimrc
copy_or_symlink

# Installing vim plugins
debugline 'Installing plugins...'
vim +PluginInstall +qall

if [ $USE_YCM -eq 1 ]; then
    debugline 'Installing YouCompleteMe C-family completer...'
    cd $HOME/.vim/bundle/YouCompleteMe/
    ./install.sh --clang-completer

    debugline 'Copying default YouCompleteMe config...'
    cp $DIR/vim/ycm_default_conf.py $HOME/.vim
fi

unset DIR
