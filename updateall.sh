#!/bin/bash
set -e
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir

## Forced checkout, discarding any local changes
#git submodule update --recursive --remote --force
## Now update to the latest of everything (equivelent of pull in each submodule)
#git submodule update --recursive --remote --merge
#git submodule update --recursive --init

# Re-build
echo "Re-building YouCompleteMe"
cd $scriptdir/bundle/YouCompleteMe
./install.py --clang-completer --go-completer --js-completer --rust-completer
