#!/usr/bin/env bash
set -e

DIR="$(pwd)"

# Backup old vim files
if [ $BACKUP -eq 0 ]; then
    debugline 'Creating directory for old vimconfig...'
    if [ -d $HOME/old-vim-config ]; then
        debugline 'Removing old directory for old vimconfig'
        rm -rf $HOME/old-vim-config
    fi
    mkdir $HOME/old-vim-config
    debugline 'Old config will be stored in "%s"\n' "$HOME/old-vim-config"

    debugline 'Copying old config...'
    if [ -d $HOME/.vim ]; then
        cp -r $HOME/.vim $HOME/old-vim-config
    fi

    if [ -e $HOME/.vimrc ]; then
        debugline 'Removing existing .vimrc...'
        rm $HOME/.vimrc
    fi

    if [ -d $HOME/.vim ]; then
        debugline 'Removing existing .vim directory...'
        rm -rf $HOME/.vim
    fi
fi

if [ $USE_YCM -eq 0 ]; then
    debugline 'Turn off YCM...'
    sed -i -e "s/Plugin 'Valloric\/YouCompleteMe'/"'"'" Plugin 'Valloric\/YouCompleteMe'/" $DIR/vim/vimrc.vim
fi

# Copying new .vimrc
if [ $COPY -eq 1 ]; then
    debugline 'Copying new .vimrc...'
    cp $DIR/vim/vimrc.vim $HOME/.vimrc
else
    if [ $HOME/.vimrc -ef $DIR/vim/vimrc.vim ]; then
        debugline 'Link already set'
    else
        if [ -f $HOME/.vimrc ] && [ ! $HOME/.vimrc -ef $DIR/vim/vimrc.vim ]; then
            debugline 'Removing existing .vimrc...'
            rm $HOME/.vimrc
        fi

        debugline 'Soft-linking new .vimrc...'
        ln -s $DIR/vim/vimrc.vim $HOME/.vimrc
    fi
fi

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
