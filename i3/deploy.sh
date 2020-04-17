#!/usr/bin/env bash
set -e

DIR="$(pwd)"

BACKUP_DIR="$HOME/old-i3-config"
CONFIG_DIR="$HOME/.config/i3/"
CONFIG_PATH="$CONFIG_PATH/config"
NEW_CONFIG_PATH="$DIR/i3/config"

backup
copy_or_symlink
