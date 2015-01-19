#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

printf 'Configuring...\n'

printf 'Configuring Vim...\n'
$DIR/vim/deploy.sh
printf 'Configuring Vim...DONE\n'

printf 'Configuring zsh & ohmyzsh...\n'
$DIR/zsh/deploy.sh
printf 'Configuring zsh...DONE\n'

if [ "$1" == '--with-message' ]; then
    $DIR/zsh/add_message.sh
fi

printf 'Configuring...DONE\n'

unset DIR
