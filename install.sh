#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $DOTFILES/config.sh

case $OS in
    macos) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
           brew install gcc make unzip git ripgrep tmux jq btop zsh rust fd python3;
    ;;
    ubuntu|debian) sudo apt update;
                   sudo apt install -y gcc make unzip git ripgrep tmux curl jq btop zsh rust-all fd-find python3;
    ;;
    arch) sudo pacman --sync --refresh;
          sudo pacman --sync --needed --noconfirm gcc make unzip git ripgrep tmux curl jq btop zsh rust fd python3;
    ;;
esac

KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.old

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

$DOTFILES/upgrade.sh
