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

export LIBRARY_PATH="/usr/local/lib"
export CPLUS_INCLUDE_PATH="/usr/local/include"
export GOPATH="/Users/tsborisova/code/go"
export MANPATH="/usr/local/man:/opt/local/share/man/:$MANPATH"
export PATH="/Users/tsborisova/bin:/usr/local/bin:/usr/local/opt/llvm/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/opt/local/bin:/opt/local/sbin:$GOPATH/bin"

alias ack-grep=ack
alias ya="~/trunk/arcadia/devtools/ya/ya"
alias yavim="~/trunk/arcadia/devtools/ya/ya tool vim"

source $ZSH/oh-my-zsh.sh

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.tar.xz)  tar xvfJ $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

sfs ()
{
    local dest="$HOME"/mnt/"$1"/;
    mkdir -p "$dest";
    sshfs "$1": "$dest" -ocache=no -ofollow_symlinks
}
