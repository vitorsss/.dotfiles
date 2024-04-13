export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

plugins=(git)

export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal
source $PERSONAL/env
for i in `find -L $PERSONAL | grep -v personal/env`; do
    source $i
done

if [[ -f $HOME/.zshrc.work ]]; then
    source $HOME/.zshrc.work
fi

source $ZSH/oh-my-zsh.sh

