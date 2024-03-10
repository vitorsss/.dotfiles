#!/bin/bash

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DOTFILES/config.sh

pushd $DOTFILES
$HOME/.cargo/bin/tuckr rm \*
popd
mv $HOME/.zshrc.old $HOME/.zshrc

