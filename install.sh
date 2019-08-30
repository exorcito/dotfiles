#!/bin/bash

DATE=$(date +%Y%m%d)
DIR=$(pwd)

#Vims conf

rm -rf $HOME/.vim
cp -Rv $DIR/vim/ $HOME/.vim/
ln -sf  $HOME/.vim/vimrc $HOME/.vimrc

cd $DIR

cp -Rv bash_aliases $HOME/.bash_aliases
cp -v gitconfig ~/.gitconfig
