#!/bin/bash

export XDG_CONFIG_HOME=$HOME/.config

export KERNEL_NAME=$(uname | tr '[:upper:]' '[:lower:]')
architecture=""
case $(uname -m) in
    i386|i686)   architecture="386" ;;
    x86_64)      architecture="amd64" ;;
    aarch64|arm) dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
    *)           echo "Unable to determine system architecture."; exit 1 ;;
esac
export KERNEL_ARCH=$architecture
