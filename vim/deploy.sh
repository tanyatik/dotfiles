#!/usr/bin/env bash
set -e

DIR="$(pwd)"

echo "use ycm $USE_YCM"
echo "fast update $FAST_UPDATE"
echo "VERBOSE $VERBOSE"

if [ $FAST_UPDATE -eq 0 ]; then
    [ $VERBOSE -eq 1 ] && printf 'Creating directory for old vimconfig...'
    if [ -d $HOME/old-vim-config ]; then
        rm -rf $HOME/old-vim-config
    fi
    mkdir $HOME/old-vim-config
    [ $VERBOSE -eq 1 ] && printf 'DONE\n'
    [ $VERBOSE -eq 1 ] && printf 'Old config will be stored in "%s"\n' "$HOME/old-vim-config"

    [ $VERBOSE -eq 1 ] && printf 'Copying old config...'
    if [ -a $HOME/.vimrc ]; then
        cp $HOME/.vimrc $HOME/old-vim-config
    fi
    if [ -d $HOME/.vim ]; then
        cp -r $HOME/.vim $HOME/old-vim-config
    fi
    [ $VERBOSE -eq 1 ] && 'DONE\n'

    if [ -a $HOME/.vimrc ]; then
        [ $VERBOSE -eq 1 ] && printf 'Removing existing .vimrc...'
        rm $HOME/.vimrc
        [ $VERBOSE -eq 1 ] && printf 'DONE\n'
    fi

    if [ -d $HOME/.vim ]; then
        [ $VERBOSE -eq 1 ] && printf 'Removing existing .vim directory...'
        rm -rf $HOME/.vim
        [ $VERBOSE -eq 1 ] && printf 'DONE\n'
    fi
fi

[ $VERBOSE -eq 1 ] && printf 'Copying new .vimrc...'
cp $DIR/vim/vimrc.vim $HOME/.vimrc
[ $VERBOSE -eq 1 ] && printf 'DONE\n'

[ $VERBOSE -eq 1 ] && printf 'Installing plugins...'
vim +PluginInstall +qall
[ $VERBOSE -eq 1 ] && printf 'DONE\n'

if [ $USE_YCM -eq 1 ]; then
    [ $VERBOSE -eq 1 ] && printf 'Installing YouCompleteMe C-family completer...'
    cd $HOME/.vim/bundle/YouCompleteMe/
    ./install.sh --clang-completer
    [ $VERBOSE -eq 1 ] && printf 'DONE\n'

    [ $VERBOSE -eq 1 ] && printf 'Copying default YouCompleteMe config...'
    cp $DIR/vim/ycm_default_conf.py $HOME/.vim
    [ $VERBOSE -eq 1 ] && printf 'DONE\n'
fi

unset DIR
