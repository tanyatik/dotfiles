#!/usr/bin/env bash
set -e

OPTIND=1
use_tmux=0
verbose=0
usage="$(basename "$0") [-h] [-t] -- program to set up some nice things, now: zsh with oh-my-zsh, vim with YCM and tmux 

where:
    -h  show this help text
    -t  use tmux on shell starting"

while getopts "h?tv" opt; do
    case "$opt" in
    h|\?)
        echo "$usage"
        exit 0
        ;;
    t)  use_tmux=1
        ;;
    v)  verbose=1
        ;;
    esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ $verbose ] && printf 'Configuring zsh\n'
$DIR/zsh/deploy.sh

[ $use_tmux ] && cat $DIR/zsh/add_tmux.sh >> "${HOME}/.zshrc"

[ $verbose ] && printf 'Configuring vim\n'
$DIR/vim/deploy.sh

[ $verbose ] && printf 'DONE\n'

unset DIR
unset usage
unset use_tmux
