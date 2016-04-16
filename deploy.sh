#!/usr/bin/env bash
set -e

# Parsing arguments

OPTIND=1
export USE_TMUX=0
export USE_YCM=0
export VERBOSE=0
export BACKUP=1
export COPY=0
# Common functions
debug () {
    [ $VERBOSE -eq 1 ] && printf "$1"
}

debugline () {
    [ $VERBOSE -eq 1 ] && printf "$1\n"
}

export -f debug
export -f debugline


usage="$(basename "$0") [-h] [-t] [-v] [-c] [-b] -- program to set up some nice things, now: zsh with oh-my-zsh, vim with YCM and tmux

where:
    -h  show this help text
    -t  use tmux on shell starting, default: no
    -v  be VERBOSE, default: no
    -b  backup old vim files, default: true
    -y  use YouCompleteMe custom build of Vim, default: no
    -c  copy files instead of linking them, default: no"

while getopts "h?tvb:yc" opt; do
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
    esac
done

DIR="$(pwd)"

# debugline 'Confiuring zsh\n'
# $DIR/zsh/deploy.sh

debugline 'Confiuring vim'
$DIR/vim/deploy.sh
debugline 'Confiuring vim DONE'

debug 'END\n'

