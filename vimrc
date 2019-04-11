"sECREt sauce
" Insert new blank line
" Delete to begining of line
" Insert space around 'word'
" Insert quotes around 'word'

" TAG, NAVIGATION & Static Analisys
" toggle scroll offset between 0 or 999
" toggle auto line breaks
""""

" LEADER <leader>
let mapleader = ","

nnoremap <F2> :NERDTreeToggle<cr>
noremap <F3> :Ack <cword><cr>
au FileType go nmap <S-F3> :GoDeclsDir<cr>

noremap <F4> :buffers<cr>

" F5 debug <filetype> (see after/ftplugin's)
noremap <F5> :DlvDebug main.go --build-flags="-gcflags='-N -l'" --
" F6 test <filetype> (see after/ftplugin's)
noremap <F6> :Pytest project<cr>
noremap <C-F6> :Pytest method<cr>
" F9 toggle debug breakpoint <filetype> (see after/ftplugin's)
noremap <F9> :DlvToggleBreakpoint<cr>

noremap <F7> :SyntasticCheck<cr>:Errors<cr>
noremap <S-F7> :lclose<cr>
noremap <F8> :TagbarToggle<cr>

nmap <silent> <Leader>f <Plug>(CommandT)
nmap <silent> <Leader>t <Plug>(CommandTTag)

noremap <leader>fn :echo expand("%:p")<cr>
noremap <leader>dycm :YcmDebugInfo<cr>

noremap <F10> :YcmCompleter GoTo<cr>:echo expand('%:p')<cr>
noremap <S-F10> "zyiw:stselect <C-R>z<cr>
noremap <leader><F10> :YcmCompleter GoToReferences<cr>
"Open (listed)tag in new window
"noremap <F10> "zyiw:tselect <C-R>z<cr>

noremap <leader>l :set scrolloff=999<cr>
noremap <leader>L :set scrolloff=0<cr>
noremap <leader>s :set spell<cr>
noremap <leader>S :set nospell<cr>
noremap <leader>g :GitGutterLineHighlightsToggle<cr>
" Toggle line numbers with <leader>nn, makes copying cleaner
noremap <leader>nn :set nonumber!<CR>:set foldcolumn=0<CR>
" Don't use Ex mode, use Q for formatting
map Q gq

set nocompatible
filetype off

" Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"----------------------------------------
" Environments
Plug 'plytophogy/vim-virtualenv'

"----------------------------------------
" Display of state of things.
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'w0rp/ale'
if has ('nvim')
  Plug 'sebdah/vim-delve'
endif

"----------------------------------------
" NAVIGATION
Plug 'christoomey/vim-tmux-navigator' "Use same window navigation for tmux and vim
Plug 'scrooloose/nerdtree'
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
Plug 'majutsushi/tagbar'

"----------------------------------------
" Finding things
Plug 'git://git.wincent.com/command-t.git'
Plug 'mileszs/ack.vim'

"----------------------------------------
" Checking things & Building things
Plug 'vim-syntastic/syntastic'
Plug 'alfredodeza/pytest.vim'
" Building things
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neomake/neomake'

"----------------------------------------
" Editing
Plug 'tpope/vim-surround'
"----------------------------------------
" Completions
"Plug 'Valloric/YouCompleteMe'
if has ('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugs' }
  Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.vim/plugged/gocode/nvim/symlink.sh' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}      " Go auto completion
Plug 'deoplete-plugins/deoplete-jedi'                     " Python auto completion
Plug 'ctrlpvim/ctrlp.vim'          " CtrlP is installed to support tag finding in vim-go

"----------------------------------------
" Syntax highlighting
"
Plug 'fatih/vim-go'                            " Go support
"Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' } " Go auto completion
Plug 'nsf/gocode'                              " Go auto completion
Plug 'pangloss/vim-javascript'                 " JavaScript syntax highlighting
Plug 'leafgarland/typescript-vim'              " TypeScript syntax highlighting
Plug 'plasticboy/vim-markdown'                 " Markdown syntax highlighting
Plug 'lifepillar/pgsql.vim'                    " PostgreSQL syntax highlighting

"Plug 'aklt/plantuml-syntax'                    " PlantUML syntax highlighting
"Plug 'cespare/vim-toml'                        " toml syntax highlighting
"Plug 'chr4/nginx.vim'                          " nginx syntax highlighting
"Plug 'dag/vim-fish'                            " Fish syntax highlighting
"Plug 'digitaltoad/vim-pug'                     " Pug syntax highlighting
"Plug 'fishbullet/deoplete-ruby'                " Ruby auto completion
"Plug 'hashivim/vim-terraform'                  " Terraform syntax highlighting
"Plug 'kchmck/vim-coffee-script'                " CoffeeScript syntax highlighting
"Plug 'kylef/apiblueprint.vim'                  " API Blueprint syntax highlighting
"Plug 'mxw/vim-jsx'                             " JSX syntax highlighting
"Plug 'rodjek/vim-puppet'                       " Puppet syntax highlighting
"Plug 'tclh123/vim-thrift'                      " Thrift syntax highlighting
"Plug 'zimbatm/haproxy.vim'                     " HAProxy syntax highlighting

call plug#end()
filetype plugin indent on

"------------------------------------------------------------------------------
" Functions
"------------------------------------------------------------------------------

" Find a file, starting at path and working upwards.
"
" Ignores the various case sensitivity settings that are user controlable.
" Returns:
"  - The empty string: If the file is not found
"  - prefix + path-to-file otherwise
"------------------------------------------------------------------------------
function! FindFileUp(prefix, what, where)
    let fn = findfile(a:what, escape(a:where, ' ') . ';')
    if a:prefix == ''
        return fn !=# '' ? escape(fn, ' ') : ''
    endif
    return fn !=# '' ? a:prefix . escape(fn, ' ') : ''
endfunction

" Exactly as FileFindUp but for a directory.
function! FindDirUp(prefix, what, where)
    let fn = finddir(a:what, escape(a:where, ' ') . ';')
    if a:prefix == ''
        return fn !=# '' ? escape(fn, ' ') : ''
    endif
    return fn !=# '' ? a:prefix . escape(fn, ' ') : ''
endfunction

function! JoinHome(path)
   return join([expand("$HOME"), a:path], "/")
endfunction

" Locate a bin directory suitable for GOBIN by searching (first) for go.mod
function! FindGoBin()

    " Prioritize go.mod found above the first file opened.
    let gomod = FindFileUp("", "go.mod", expand("%:h"))
    if gomod != ''
        return join([fnamemodify(gomod, ":h"), "bin"], "/")
    endif

    " From current working directory
    let gomod = FindFileUp("", "go.mod", getcwd())
    if gomod != ''
        return join([getcwd(), fnamemodify(gomod, ":h"), "bin"], "/")
    endif
    " Special, From current working directory/src
    let gomod = FindFileUp("", "go.mod", getcwd() . "/src")
    if gomod != ''
        return join([getcwd(), fnamemodify(gomod, ":h"), "bin"], "/")
    endif

    " Fallback to conventional user globals
    let gobin = expand("$GOBIN")
    if gobin != "$GOBIN"
        return gobin
    endif

    let gopath = expand("$GOPATH")
    if gopath != "$GOPATH"
        return join([gopath, "bin"], "/")
    endif

    return JoinHome("go/bin")

endfunction

let g:context_derived_gobin = FindGoBin()
let g:context_derived_gopath = fnamemodify(g:context_derived_gobin, ":h")


" Plugs to disable.
"set runtimepath-=~/.vim/bundle/tagbar
"set runtimepath-=~/.vim/bundle/ropevim
let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
if win_shell
  " c-extention 'installed' for linux ... attempting to load yields segv
  "
  " Not sure what defines vimfilesdir ...
  let home=join(split($HOME, '/'), '\')
  "let vimfilesdir=home . "\\Dropbox\\vimfiles"
  let vimfilesdir=home . "\\vimfiles"
  "exec "set runtimepath-=" . vimfilesdir . "\\bundle\\YouCompleteMe"
endif
"

"------------------------------------------------------------------------------
" CONFIGURATION
"------------------------------------------------------------------------------
"
" Gui options
set guioptions-=T "remove gui tool bar.

"----------------------------------------
"Big behaviour {{{1
" [1]http://dancingpenguinsoflight.com/2009/02/python-and-vim-make-your-own-ide/

set formatoptions=tcjnq
"set gdefault                   " global replace s/x/y/g by default.
set ignorecase                  " coupled with smartcase, this means insensitive
set smartcase                   " unless search string is mixed case.
set modelines=0                 " Prevents some exploits.
set viminfo='100,f1             " Save marks for 100 files, save global marks
set shortmess=AI
set noequalalways               " don't make all windows same size after split
set autowrite                   " write file whenever you get taken elsewhere
set nowrap
"set autochdir                  " Change to the directory of the file in the
                                " new buffer - NOTE this breaks session saving.
                                " See <http://vim.wikia.com/wiki/VimTip64>


" Show whitespace
set list listchars=tab:`\ ,trail:-

" Biased for terminal use, hence wrap at 79
set wrap
set textwidth=79

if version >= 703
    set colorcolumn=80
endif

set backspace=2
set splitbelow                  " edit new files in buffer below current one

" turn on line numbers
set number

" turn on syntax highlighting
syntax on

" Set if you want the 'page to move under the cursor'
"set scrolloff=99999

" Disable middle mouse paste - what a truly *stupid* default
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

if version >= 600
    "filetype plugin on
    "filetype plugin indent on
    "filetype indent on
    colorscheme marklar
endif

" Also switch on highlighting the last used search pattern.
if has("syntax") && (&t_Co > 2 || has("gui_running"))
  "syntax on
  set hlsearch
endif

"----------------------------------------
" STATUS LINE - vim-airline
let g:airline#extentions#tabline#enabled = 1

" Disable showing tabs in the tabline. This will ensure that the buffers are
" what is shown in the tabline at all times.
let g:airline#extensions#tabline#show_tabs = 0

"set statusline+=...[%{&fo}]...
"----------------------------------------
" Environments
"
set statusline+=%{virtualenv#statusline()}
let g:virtualenv_directory = '~/.pyenv/versions'

"----------------------------------------
" Navigation and Folding
"----------------------------------------
"
"----------------------------------------

"vim-airline tabline options
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Tags
" With the following setting, Vim will search for the file named 'tags',
" starting with the directory of the current file and then going to the parent
" directory and then recursively to the directory one level above, till it
" either locates the 'tags' file or reaches the root directory
set tags=./tags;

" YouCompleteMe options
let g:ycm_collect_identifiers_from_tags_files = 1


let g:fastfold_savehook = 0 " Don't update folds on save
let g:SimpylFold_docstring_preview = 1 "Preview the folded doc strings


" Language: Go

" Always prefer the context derived GOPATH and GOBIN

let $GOBIN = g:context_derived_gobin
let $GOPATH = g:context_derived_gopath


" Tagbar configuration for Golang
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Plug: plasticboy/vim-markdown
" Disable folding
let g:vim_markdown_folding_disabled = 1

" Auto shrink the TOC, so that it won't take up 50% of the screen
let g:vim_markdown_toc_autofit = 1

" Plug: scrooloose/nerdtree
"nnoremap <leader>d :NERDTreeToggle<cr>

" Files to ignore
let NERDTreeIgnore = [
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]

" Close vim if NERDTree is the only opened window.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Show hidden files by default.
let NERDTreeShowHidden = 1

" Allow NERDTree to change session root.
let g:NERDTreeChDirMode = 2

let g:python3_host_default='python3' " Isn't going to work, but errors will make sense.
for py3path in [
  \ '/Users/robin/.pyenv/versions/neovim3/bin/python3',
  \ '/Users/puk/.pyenv/versions/py3neovim/bin/python3',
  \ '/Users/puk/pyenvs/pydev/bin/python3']
  if filereadable(py3path)
    let g:python3_host_default=py3path
    break
  endif
endfor
"----------------------------------------
" Completions
"
" Deoplete
let g:python3_host_default = python3_host_default
let g:python_host_prog = python3_host_default
if has('nvim')
    " Enable deoplete on startup
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#jedi#python_path = python3_host_default
endif

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction


"----------------------------------------
" Checking things and building things
"
" Syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

"Only populate location list when :Errors is run
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" syntastic - go --------------------------------------------------------------
let g:syntastic_go_checkers = ['go', 'golint', 'govet']
" syntastic - python ----------------------------------------------------------
let g:syntastic_python_python_exec = '~/.pyenv/versions/pydev3/bin/python3'
let g:syntastic_python_pylint_exec = 'pylint'

" Note: python path can be manipulated in pylintrc
"let g:syntastic_python_pylint_args = '--rcfile=~/dotfiles/pylintrc'

let g:syntastic_python_checkers = ['pep8']
"let g:syntastic_python_checkers = ['pylint']


" Plug: neomake/neomake
"
" Configure signs.
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" Ale

let g:ale_linters = {'go':['gofmt', 'golangci-lint']}

let g:ale_lint_on_text_changed=0

" Prefer the context derived gobin directory
if filereadable(g:context_derived_gobin . "/golangci-lint")
    let g:ale_go_golangci_lint_executable = join([
        \ g:context_derived_gobin, 'golangci-lint'], '/')
endif
" Otherwise, rely on usual GOPATH/GOBIN

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" Per Language settings (checking, completion, etc)
"
" go golang Go

" This puts a wrapper script for the go binary at the front of the path. The
" wrapper arranges for 'go' to execute in a container
let $PATH='~/jitsuin/robinbryce/workflow/vimgo:' . $PATH
let g:go_bin_path = g:context_derived_gobin
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" highlighting of all variables of same name
let g:go_auto_sameids = 1

" Automatically add imports as they are used, not always correct but overall a
" productivity saving ?
let g:go_fmt_command = "goimports"

"----------------------------------------
" Debugging
" Plug: sebdah/vim-delve
" Set the Delve backend.
let g:delve_backend = "native"


