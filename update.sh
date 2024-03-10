#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $DOTFILES/config.sh

case $OS in
    macos) brew update;
    ;;
    ubuntu|debian) sudo apt update;
    ;;
    arch) sudo pacman --sync --refresh;
    ;;
esac
