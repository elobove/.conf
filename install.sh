#!/bin/bash

set -e

sudo apt-get install git curl zsh tree python3-pip powerline emacs unzip lhs2tex
sudo pip install powerline-gitstatus

# For WSL
sudo apt-get install terminator

# oh-myzsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Installing lsd (better ls)
sudo apt-get install cargo
cargo install lsd
mkdir -p .local/bin
cd .local/bin
ln -s $HOME/.cargo/bin/lsd
cd

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
cp ls $HOME/.local/bin/ls-i
cd ../../

# Fonts
mkdir -p .local/share/fonts
cd .local/share/fonts
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/DejaVuSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
sudo apt-get install unzip
unzip JetBrainsMono
# Set font in terminal to something with nerd and powerline in it ;)
fc-cache -f .

# Creating symbolic links to conf files
cd
rm .bashrc
ln -s $HOME/.conf/.bashrc
ln -s $HOME/.conf/.emacs
ln -s $HOME/.conf/.zshrc
ln -s $HOME/.conf/.gitconfig

# Installing ghc
# sudo apt-get install ghc
# wget https://downloads.haskell.org/~ghc/8.4.4/ghc-8.4.4-x86_64-deb9-linux.tar.xz
# cd ghc-8.4.4
# ./configure
# sudo make install
# cd /usr/bin/
# sudo ln -s /usr/local/bin/ghc

# Installing stack
curl -sSL https://get.haskellstack.org/ | sh

# Installing cabal
# sudo apt-get install cabal-install
# cabal update
# cd $HOMEDownloads
# wget https://www.haskell.org/cabal/release/cabal-2.4.0.1/Cabal-2.4.0.1.tar.gz
# tar -xf Cabal-2.4.0.1.tar.gz
# cd Cabal-2.4.0.1
# cabal install

# Installing agda
cd $HOME
mkdir agda-full
cd agda-full
sudo apt-get update
sudo apt-get install zlib1g-dev libncurses5-dev
git clone git@github.com:agda/agda.git
cd agda
git co v2.6.2
stack --stack-yaml stack-8.10.5.yaml build

mkdir -p $HOME/.cabal/bin
cd $HOME/.cabal/bin
ln -s $HOME/agda-full/agda/.stack-work/install/x86_64-linux-tinfo6/551038fd25d597730aabf0e9af25840bd5a93d664c8449f600a28ab2b0931b53/8.10.5/bin/agda 
ln -s $HOME/agda-full/agda/.stack-work/install/x86_64-linux-tinfo6/551038fd25d597730aabf0e9af25840bd5a93d664c8449f600a28ab2b0931b53/8.10.5/bin/agda-mode

# agda std-library
cd $HOME/agda-full/
git clone https://github.com/agda/agda-stdlib.git
cd agda-stdlib
git checkout v1.7
cd $HOME
mkdir .agda
cd .agda
echo "$HOME/agda-full/agda-stdlib/standard-library.agda-lib" >> libraries
echo "standard-library" >> defaults
cd $HOME

# latex
sudo apt-get install texlive-full
