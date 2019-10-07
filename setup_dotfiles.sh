#!/bin/bash

set -e

sudo yum install -y zsh screen vim
for dotfile in {zsh,screen,vim}
do
    curl -o ${HOME}/".${dotfile}rc" "https://raw.githubusercontent.com/Vaduz/dotfiles/master/.${dotfile}rc"
done

echo "alias s='screen -D -RR'" >> "${HOME}/.bashrc"
