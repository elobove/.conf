#!/bin/bash

set -e

sudo apt-get install git curl zsh tree python3-pip powerline

sudo pip install powerline-gitstatus

# oh-myzsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Installing lsd (better ls)
sudo apt-get install cargo
cargo install lsd
mkdir .local
mkdir .local/bin
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

# fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/DejaVuSansMono.zip
mkdir -p $HOME/.local/share/fonts
cp DejaVuSansMono.zip $HOME/.local/share/fonts/
cd $HOME/.local/share/fonts
unzip DejaVuSansMono.zip
fc-cache -f .
# Set font in terminal to something with nerd and powerline in it ;)

cd -

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
git co v2.5.4.1
stack --stack-yaml stack-8.4.3.yaml build

mkdir $HOME/.cabal/
cd $HOME/.cabal
mkdir bin
cd $HOME/.cabal/bin
ln -s $HOME/agda-full/agda/.stack-work/install/x86_64-linux/lts-12.0/8.4.3/bin/agda
ln -s $HOME/agda-full/agda/.stack-work/install/x86_64-linux/lts-12.0/8.4.3/bin/agda-mode

# agda std-library
cd $HOME/agda-full/
git clone https://github.com/agda/agda-stdlib.git
cd agda-stdlib
git checkout v0.17
cd $HOME
mkdir .agda
cd .agda
echo "$HOME/agda-full/agda-stdlib/standard-library.agda-lib" >> libraries
echo "standard-library" >> defaults
cd $HOME

# latex
sudo apt-get install texlive-full
