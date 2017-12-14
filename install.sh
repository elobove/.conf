#!/bin/bash

set -e

sudo apt-get install git curl zsh tree python-pip powerline

sudo pip install powerline-gitstatus

# even better ls

wget http://raw.githubusercontent.com/illinoisjackson/even-better-ls/master/ls_colors_generator.py
chmod 755 ls_colors_generator.py
cp ls_colors_generator.py ~/.local/bin/ls_colors_generator
wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.2.tar.xz
tar -xf coreutils-8.2.tar.xz
rm coreutils-8.2.tar.xz
cd coreutils-8.2/src
rm -rf ls.c
wget http://raw.githubusercontent.com/illinoisjackson/even-better-ls/master/ls.c
cd ..
./configure
make
cd src
make ls
cp ls ~/.local/bin/ls-i
cd ../../

# fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/DejaVuSansMono.zip
mkdir -p ~/.local/share/fonts
cp DejaVuSansMono.zip ~/.local/share/fonts/
cd ~/.local/share/fonts
unzip DejaVuSansMono.zip
fc-cache -f .
# Set font in terminal to something with nerd and powerline in it ;)

cd -
