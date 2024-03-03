#!/bin/env bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DOTFILES/config.sh

pushd $DOTFILES
for folder in $STOW_FOLDERS; do
    echo "Removing $folder"
    stow -D $folder
done
popd
mv $HOME/.zshrc.old $HOME/.zshrc

