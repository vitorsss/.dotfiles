#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DOTFILES/config.sh

$DOTFILES/update.sh

if [[ "$KERNEL_NAME" == "darwin" ]]; then
    brew upgrade
else
    sudo apt upgrade -y
fi

if [[ "$KERNEL_NAME" == "darwin" ]]; then
    curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-macos.tar.gz
    xattr -c nvim.tar.gz
else
    curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
fi
sudo rm -rf /usr/local/nvim*
sudo tar -C /usr/local -xzf nvim.tar.gz
rm -f nvim.tar.gz

curl -L -o go.tar.gz https://go.dev/dl/$(curl -s https://go.dev/VERSION\?m\=text | head -n 1).$KERNEL_NAME-$KERNEL_ARCH.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go.tar.gz
rm -f go.tar.gz

pushd $DOTFILES
for folder in $STOW_FOLDERS; do
  echo "stow -R $folder"
  stow -R $folder
done
popd

/usr/local/go/bin/go install github.com/junegunn/fzf@latest

