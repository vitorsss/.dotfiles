#!/bin/env bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DOTFILES/config.sh

$DOTFILES/update.sh

sudo apt upgrade -y

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim*
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm -f nvim-linux64.tar.gz

curl -LO https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo rm -rf /url/local/go
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
rm -f go1.22.0.linux-amd64.tar.gz

pushd $DOTFILES
for folder in $STOW_FOLDERS; do
  echo "stow -R $folder"
  stow -R $folder
done
popd

/usr/local/go/bin/go install github.com/junegunn/fzf@latest

