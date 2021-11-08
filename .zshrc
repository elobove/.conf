# .zshrc

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME=""

plugins=(git)

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/.cabal/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export PATH=$HOME/Documents/MATLAB/mosek/8/tools/platform/linux64x86/bin:$PATH

# Some aliases
alias ls="lsd"
alias ll="lsd -lh"
alias lt="lsd -tree"

alias ag="ag --pager less"

alias e='XMODIFIERS=\" emacs'

# Powerline
. /usr/share/powerline/bindings/zsh/powerline.zsh
