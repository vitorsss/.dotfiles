#!/bin/env bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo apt update
sudo apt install -y gcc make unzip git ripgrep stow tmux jq btop zsh

KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.old

$DOTFILES/upgrade.sh
