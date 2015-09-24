#!/bin/bash
set -e
cd ~/vimfiles/bundle
git submodule foreach git pull origin master
