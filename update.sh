#!/bin/bash

KERNEL_NAME=$(uname | tr '[:upper:]' '[:lower:]')
if [[ $KERNEL_NAME == "darwin" ]]; then
    brew update
else
    sudo apt update
fi
