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

export NVM_DIR="$([ -d "${XDG_CONFIG_HOME-}/nvm" ] && printf %s "${XDG_CONFIG_HOME}/nvm" || printf %s "${HOME}/.nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use # This loads nvm

nvm install stable

export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

sdk selfupdate
sdk install java 22-amzn
sdk install java 11.0.22-amzn
sdk install java 8.0.402-amzn

cargo install --git https://github.com/RaphGL/Tuckr.git
cargo install gitui --locked

if [[ "$KERNEL_NAME" == "darwin" ]]; then
    if [[ "$KERNEL_ARCH" == "arm64" ]]; then
        curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz
    else
        curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz
    fi
    xattr -c nvim.tar.gz
else
    if [[ "$KERNEL_ARCH" == "arm64" ]]; then
        curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
    else
        curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    fi
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

