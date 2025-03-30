# time ZSH_DEBUGRC=1 zsh -i -c exit
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

plugins=(git fzf)

export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal
source $PERSONAL/env
for i in `find -L $PERSONAL -type f | grep -v personal/env`; do
    source $i
done

if [[ -f $HOME/.zshrc.work ]]; then
    source $HOME/.zshrc.work
fi

source $ZSH/oh-my-zsh.sh

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
