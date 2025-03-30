#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $DOTFILES/config.sh

case $OS in
    macos) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
           brew install gcc make unzip zip git ripgrep tmux jq btop zsh rust fd python3 platformio ncspot ghostty;
    ;;
    ubuntu|debian) sudo apt update;
                   sudo apt install -y gcc make unzip zip git ripgrep tmux curl jq btop zsh rust-all fd-find python3 platformio ncspot ghostty;
    ;;
    arch) sudo pacman --sync --refresh;
          sudo pacman --sync --needed --noconfirm gcc make unzip zip git ripgrep tmux curl jq btop zsh rust fd python3 platformio-core ncspot ghostty;
    ;;
esac

KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.old

curl -s "https://get.sdkman.io" | bash

$DOTFILES/upgrade.sh
