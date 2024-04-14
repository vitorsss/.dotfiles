#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DOTFILES/config.sh

$DOTFILES/update.sh

case $OS in
    macos) brew upgrade;
    ;;
    ubuntu|debian) sudo apt upgrade -y;
    ;;
    arch) sudo pacman --sync --sysupgrade --noconfirm;
    ;;
esac

nvm install stable

sdk selfupdate
sdk install java 22-amzn
sdk install java 11.0.22-amzn
sdk install java 8.0.402-amzn

cargo install --git https://github.com/RaphGL/Tuckr.git

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
$HOME/.cargo/bin/tuckr add \*
popd

/usr/local/go/bin/go install github.com/junegunn/fzf@latest

