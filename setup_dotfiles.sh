#!/bin/bash

set -e

sudo yum install -y zsh screen tmux vim
for dotfile in {zsh,screen,vim}
do
    curl -o ${HOME}/".${dotfile}rc" "https://raw.githubusercontent.com/Vaduz/dotfiles/master/.${dotfile}rc"
done
curl -o ${HOME}/.tmux.conf "https://raw.githubusercontent.com/Vaduz/dotfiles/master/.tmux.conf"

echo "alias s='screen -D -RR'" >> "${HOME}/.bashrc"
