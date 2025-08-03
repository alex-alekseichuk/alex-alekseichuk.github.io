#!/usr/bin/env bash
cd ~
if [ "$(id -u)" -eq 0 ]; then
    apt update -y
    apt install -y git
else
    sudo apt update -y
    sudo apt install -y git
fi
git clone https://github.com/alex-alekseichuk/.dotfiles.git
chmod a+x ~/.dotfiles/install.sh
~/.dotfiles/install.sh

