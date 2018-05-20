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

echo "Re-buiding command-t"
cd $scriptdir/bundle/command-t/ruby/command-t/ext/command-t
# rbenv global 2.5.1 ?
# This should pick up whatever rbenv has set (local or global) and will at
# least be correct for command line vim.
$(which ruby) extconf.rb
make clean
make
