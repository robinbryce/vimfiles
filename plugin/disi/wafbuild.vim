"
" On BufRead, discover all configuration variables that make sense for the
" current buffer.
"
" On QuickFixCmdPre/Post apply and restore configuration variables. For example
" the current working directory, which *must* be set for waf
"
" Variables:
"
" b:wafroot
"
"
" furture generalisation
"
" heuristics for determining appropriate makeprg
"
" - implement find_nearestof(magicfiles)
" - having "found" the nearest magic file, ie wscript or SConscript pass as
"   'markerfile' to find_furthest'
" - consult table which provides appropriate makeprg for the magic file. Ie
"   "python\ waf" or "scons"
" ? extra marks, implement a config file which enables path/glob based
"   overrides & exclusions
"
"

if !has("python")
"    finish "no python support
endif

" load this plugin once per buffer
if exists("b:did_wafbuild_plugin")
    finish " only load once
else
    let b:did_wafbuild_plugin = 1
endif


if version < 700
  finish
endif

python << endpython
import vim
from os.path import isfile, isdir, join, dirname
import sys

scriptdir = vim.eval('fnamemodify(resolve(expand("<sfile>:p")), ":h")')
sys.path.insert(0, dirname(scriptdir))

from disi.pathutils import find_furthest

def clear_wafroot():
    """Delete the buffer variable b:wafroot"""

    if int(vim.eval('exists("b:wafroot")')) != 0:
        vim.command('echom "wafbuild: clearing b:wafroot"')
        vim.command('unlet b:wafroot')

def set_wafroot():
    """Sets b:wafroot

    To the oldest ancestor directory which contains a wscript
    """

    if not vim.current.buffer.name:
        clear_wafroot()
        return
    bufdir = dirname(vim.current.buffer.name)
    wscriptdir = find_furthest('wscript', startdir=bufdir)
    if wscriptdir is not None:
        vim.command('let b:wafroot="' + str(wscriptdir).encode('string-escape') + '"')
    else:
        clear_wafroot()
endpython

function! SetupLocalMakePrg()
    python set_wafroot()
    "setlocal makeprg="python waf build-" . b:configured_comp
    if !exists("b:configured_comp")
        call SetupForCompiler(g:My_DefaultCompiler)
    endif
    exec "setlocal makeprg=python\\ waf\\ build-" . b:configured_comp
endfunction

let g:compcfgs = {
            \"gcc": {"compiler":"mingw-gcc"},
            \"msvc": {"compiler":"msvc"}
            \}

function! SetupForCompiler(comp)
    setlocal makeprg=python\ waf
    let cwd = getcwd()
    exec "cd " . b:wafroot
    let cfg=g:compcfgs[a:comp]
    make distclean
    if has_key(cfg, "configure")
        exec "make configure " . cfg["configure"]
    else
        make configure
    endif
    echom cfg["compiler"]
    exec "compiler! " . cfg["compiler"]
    let b:configured_comp=a:comp
    exec "cd " . cwd
    exec "setlocal makeprg=python\\ waf\\ build-" . b:configured_comp
endfunction

au BufReadPost,BufNewFile \f\+.\([ch]\>\|[ch]pp\|hxx\|py\)\|wscript call SetupLocalMakePrg()

au QuickFixCmdPre make exec "cd " . b:wafroot
au QuickFixCmdPost make exec "cd -"
