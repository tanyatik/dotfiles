#!/usr/bin/env bash
set -e

# Parsing arguments

OPTIND=1
export USE_TMUX=0
export USE_YCM=0
export VERBOSE=0
export BACKUP=1
export COPY=0
export I3=0
# Common functions
debug () {
    [ $VERBOSE -eq 1 ] && printf "$1"
}

debugline () {
    [ $VERBOSE -eq 1 ] && printf "$1\n"
}

# requires BACKUP, BACKUP_DIR, CONFIG_PATH to be set
backup() {
    # Backup old files
    if [ $BACKUP -eq 0 ]; then

        debugline 'Creating directory for old config...'
        if [ -d $BACKUP_DIR ]; then
            debugline 'Removing old directory for old config'
            rm -rf $BACKUP_DIR
        fi
        mkdir $BACKUP_DIR
        debugline 'Old config will be stored in "%s"\n' "$BACKUP_DIR"

        debugline 'Copying old config...'
        if [ -d $CONFIG_PATH ]; then
            cp -r $CONFIG_PATH $BACKUP_DIR
        fi

        if [ -d $CONFIG_PATH ]; then
            debugline 'Removing existing config directory...'
            rm -rf $CONFIG_PATH 
        fi
    fi
}

copy_or_symlink() {
    # Copying new config file 
    if [ $COPY -eq 1 ]; then
        debugline 'Copying new .vimrc...'
        cp $NEW_CONFIG_PATH $CONFIG_PATH
    else
        if [ $CONFIG_PATH -ef $NEW_CONFIG_PATH ]; then
            debugline 'Link already set'
        else
            if [ -f $CONFIG_PATH ] && [ ! $CONFIG_PATH -ef $NEW_CONFIG_PATH ]; then
                debugline 'Removing existing .vimrc...'
                rm $CONFIG_PATH
            fi

            debugline 'Soft-linking new .vimrc...'
            ln -s $NEW_CONFIG_PATH $CONFIG_PATH
        fi
    fi
}

export -f debug
export -f debugline
export -f backup
export -f copy_or_symlink

usage="$(basename "$0") [-h] [-t] [-v] [-c] [-b] -- program to set up dotfiles, as of now: zsh with oh-my-zsh, vim with YCM and tmux

where:
    -h  show this help text
    -t  use tmux on shell starting, default: no
    -v  be VERBOSE, default: no
    -b  backup old files, default: no
    -y  use YouCompleteMe custom build of Vim, default: no
    -c  copy files instead of linking them, default: no
    -i  use I3, default: no"


while getopts "h?tvb:yci" opt; do
    case "$opt" in
    h|\?)
        echo "$usage"
        exit 0
        ;;
    t)
        USE_TMUX=1
        ;;
    v)
        VERBOSE=1
        ;;
    y)
        USE_YCM=1
        ;;
    b)
        if [ -n "$OPTARG" ]; then
            if [ "$OPTARG" = "1" ]; then
                BACKUP=1
            else
                BACKUP=0
            fi
        fi
        ;;
    c)
        COPY=1
        ;;
    i) 
	I3=1
	;;
    esac
done

DIR="$(pwd)"

debugline 'Confiuring zsh...'
$DIR/zsh/deploy.sh
debugline 'Confiuring zsh DONE'

debugline 'Confiuring vim...'
$DIR/vim/deploy.sh
debugline 'Confiuring vim DONE'

debugline 'Configuring i3...'
$DIR/i3/deploy.sh
debugline 'Configuring i3 DONE'

debug 'Success.'

exit 0
