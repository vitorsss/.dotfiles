#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $DOTFILES/config.sh

case $OS in
    macos) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
           brew install gcc make unzip zip git ripgrep tmux jq btop zsh rust fd python3 platformio;
    ;;
    ubuntu|debian) sudo apt update;
                   sudo apt install -y gcc make unzip zip git ripgrep tmux curl jq btop zsh rust-all fd-find python3 platformio;
    ;;
    arch) sudo pacman --sync --refresh;
          sudo pacman --sync --needed --noconfirm gcc make unzip zip git ripgrep tmux curl jq btop zsh rust fd python3 platformio-core;
    ;;
esac

KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.old

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm

curl -s "https://get.sdkman.io" | bash
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

$DOTFILES/upgrade.sh
