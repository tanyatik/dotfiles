# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# oh-my-zsh configs
PLATFORM="$(uname)"
if [[ "${PLATFORM}" == *Darwin* ]]; then
    plugins=(git svn pip osx brew)
else
    plugins=(git svn pip)
fi

# User configuration

export PATH="/Users/tanyatik/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/opt/local/bin:/opt/local/sbin"
export MANPATH="/usr/local/man:/opt/local/share/man/:$MANPATH"

source $ZSH/oh-my-zsh.sh
