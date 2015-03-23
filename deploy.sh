#!/usr/bin/env bash
set -e

OPTIND=1
export USE_TMUX=0
export USE_YCM=0
export VERBOSE=0
export FAST_UPDATE=0

usage="$(basename "$0") [-h] [-t] [-v] -- program to set up some nice things, now: zsh with oh-my-zsh, vim with YCM and tmux

where:
    -h  show this help text
    -t  use tmux on shell starting, default: no
    -v  be VERBOSE, default: no
    -f  fast update configs, default: no
    -y  use YouCompleteMe custom build of Vim, default: no"

while getopts "h?tvyf" opt; do
    case "$opt" in
    h|\?)
        echo "$usage"
        exit 0
        ;;
    t)  USE_TMUX=1
        ;;
    v)  VERBOSE=1
        ;;
    y)  USE_YCM=1
        ;;
    f)  FAST_UPDATE=1
        ;;
    esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

DIR="$(pwd)"

[ $VERBOSE -eq 1 ] && printf 'Configuring zsh\n'
$DIR/zsh/deploy.sh

[ $VERBOSE -eq 1 ] && printf 'Configuring vim\n'
$DIR/vim/deploy.sh

[ $VERBOSE -eq 1 ] && printf 'DONE\n'

