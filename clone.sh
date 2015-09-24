#!/bin/bash
git clone https://github.com/robinbryce/vimfiles.git ~/vimfiles
ln -s ~/vimfiles ~/.vim
ln -s ~/vimfiles/vimrc ~/.vimrc
cd ~/.vim
git submodule update --init
