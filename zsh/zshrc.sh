# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# oh-my-zsh configs
PLATFORM="$(uname)"
if [[ "${PLATFORM}" == *Darwin* ]]; then
    plugins=(git ssh-agent pip osx brew)
else
    plugins=(git ssh-agent pip nvm)
fi

RPROMPT="[%D{%y/%m/%f}|%@]"

# User configuration

export LIBRARY_PATH="/usr/local/lib"
export CPLUS_INCLUDE_PATH="/usr/local/include"
export MANPATH="/usr/local/man:/opt/local/share/man/:$MANPATH"
export GOROOT="/usr/local/go"
export PATH="/Users/tsborisova/bin:/usr/local/bin:/usr/local/bin/CLion:/usr/local/opt/llvm/bin/:/bin:/usr/sbin:/sbin:/usr/texbin:/opt/local/bin:/opt/local/sbin:$GOROOT/bin:/usr/local/Cellar/openssl/1.0.2p/bin:/usr/bin:/usr/local/opt/openvpn/sbin:/usr/local/opt/postgresql@9.6/bin:$PATH:"
# alias ack-grep=ack
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
export EDITOR='vim'
export VISUAL='vim'

alias cmd="/cygdrive/c/Windows/System32/cmd.exe"
alias sublime="/cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"
alias explorer="/cygdrive/c/Windows/explorer.exe"
alias boss="echo 'WHO DA BOSS??' && git log --pretty=format:\"%x09%an\" --since \"last month\" . | sort | uniq -c | sort --reverse | head"

# Autojump requirements
# [[ -s /cygdrive/c/Users/taboris/.autojump/etc/profile.d/autojump.sh ]] && source /cygdrive/c/Users/taboris/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

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

# add tmux on login
# if [[ -z "$TMUX" ]]; then
#    tmux has-session &> /dev/null
#    if [ $? -eq 1 ]; then
#        exec tmux new
#        exit
#    else
#        exec tmux attach
#        exit
#    fi
#fi

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# setxkbmap -layout us,ru                                                                                                                                                                                                                                                                                                                             [20/03/12| 5:37PM]
# setxkbmap -option grp:alt_space_toggle                                                                                                                                                                                                                                                                                                              [20/03/12| 5:37PM]
# setxkbmap -option altwin:swap_lalt_lwin                                                                                                                                                                                                                                                                                                             [20/03/12| 5:37PM]

