export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

plugins=(git)

source $ZSH/oh-my-zsh.sh

export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal
source $PERSONAL/env
for i in `find -L $PERSONAL | grep -v personal/env`; do
    source $i
done

alias gotest="go test -coverprofile=c.out -timeout=30s -shuffle=on ./... && go tool cover -func=c.out && go tool cover -html=c.out"

