#!/bin/bash

export XDG_CONFIG_HOME=$HOME/.config

export KERNEL_NAME=$(uname | tr '[:upper:]' '[:lower:]')

if [[ "$KERNEL_NAME" == "darwin" ]]; then
    export OS="macos"
elif [[ -f /etc/os-release ]]; then
    . /etc/os-release
    export OS=$ID
elif [[ -f /etc/lsb-release ]]; then
    . /etc/lsb-release
    export OS=$(echo $DISTRIB_ID | tr '[:upper:]' '[:lower:]')
else
    export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
fi

architecture=""
case $(uname -m) in
    i386|i686)   architecture="386" ;;
    x86_64)      architecture="amd64" ;;
    arm64)       architecture="arm64" ;;
    aarch64|arm) dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
    *)           echo "Unable to determine system architecture."; exit 1 ;;
esac
export KERNEL_ARCH=$architecture
