" <leader> shortcuts {{{1
" quick edit & reload of this file.

"PYLINT as MAKE
":set makeprg=/opt/appliance/container/common/mypy/bin/pylint\ --pylint=/opt/appliance/baseimage/sourcechecks/pylint.conf\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p

"Must precede filetype detection
:call pathogen#infect()
:call pathogen#helptags()

:nnoremap <leader>tp :set sw=4 ts=4 et<cr>
:nnoremap <leader>bb :buffers<cr>
":nnoremap <leader>ms :call SetupForCompiler(g:My_DefaultCompiler)
":nnoremap <leader>mm :make<cr>
":nnoremap <leader>mt :!ctags -R --languages="python" $(pwd)<cr>

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
":nnoremap <leader>sv :source $MYVIMRC<cr>
":nnoremap <leader>ss :source %<cr>

":noremap <leader>evf :e $MYVIMRC:h
:noremap <leader>pr :cd /opt/appliance/container<cr>
" }}}1

" Key Mappings {{{1
"
" TAG NAVIGATION

""""
"Open (listed)tag in new window
noremap <C-F12> "zyiw:stselect <C-R>z<cr>
" because sometimes F12 is accessed via a function key
noremap <C-F10> "zyiw:stselect <C-R>z<cr>

""""
"Open (listed)tag in current window
noremap <F12> "zyiw:tselect <C-R>z<cr>
" because sometimes F12 is accessed via a function key
noremap <F10> "zyiw:tselect <C-R>z<cr>


" SEARCH
"
noremap <F9> "zyiw:vimgrep <C-R>z **/*.py

" Toggle line numbers with <leader>nn, makes copying cleaner
noremap <leader>nn :set nonumber!<CR>:set foldcolumn=0<CR>
" Don't use Ex mode, use Q for formatting
" ??? noremap <F12> :set nonumber!<CR>:set foldcolumn=0<CR>
map Q gq

"}}}1

" globals that effect various plugins {{{1
"
" Disable all the function key bindings from c.vim
let g:C_DisableMappings=1
let g:My_DefaultCompiler="mingw-gcc"

" because it zaps the contents of the quick fix window when I jump to a file.
let g:pyflakes_use_quickfix = 0
" }}}1

" tags {{{1
" With the following setting, Vim will search for the file named 'tags',
" starting with the directory of the current file and then going to the parent
" directory and then recursively to the directory one level above, till it
" either locates the 'tags' file or reaches the root directory
set tags=./tags;
"}}}1
"
"Big behaviour {{{1
" [1]http://dancingpenguinsoflight.com/2009/02/python-and-vim-make-your-own-ide/
set viminfo='100,f1              " Save marks for 100 files, save global marks
set nocompatible                " Use Vim defaults (much better!)
set shortmess=AI
set noequalalways               " don't make all windows same size after split
set autowrite                   " write file whenever you get taken elsewhere
set nowrap
"set autochdir                   " Change to the directory of the file in the
                                " new buffer - NOTE this breaks session saving.
                                " See <http://vim.wikia.com/wiki/VimTip64>

set sw=4 ts=4 smarttab et
set textwidth=79
if version >= 730
    set colorcolumn=80
endif
set statusline +=col:\ %c
set list listchars=tab:`\ ,trail:-

set wrap

" I prefer seeing tabs to controling where wrap breaks lines.
"set linebreak
"set nolist "list disables linebreak


set backspace=2
set splitbelow                  " edit new files in buffer below current one

" turn on line numbers
set number

" turn on syntax highlighting
syntax on

set scrolloff=99999
" Disable middle mouse paste - what a truly *stupid* default
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

if version >= 600
    filetype on
    filetype plugin on
    "filetype plugin indent on
    filetype indent on
    colorscheme marklar
endif

" Also switch on highlighting the last used search pattern.
if has("syntax") && (&t_Co > 2 || has("gui_running"))
  "syntax on
  set hlsearch
endif

if has("gui_running")
    if (! exists('gui_set'))
        set lines=41
        set columns=120
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
        let g:gui_set=1
    endif
endif

" Grep program. I think the Linux version is right by default.
" Can I get this working for RISC OS?

if has("win32")
  set grepprg=search\ -n
  set grepformat=%f:%l:%m
endif

"}}}1

"Excplicit filetype stuff {{{1
if version >= 500

"effectively, disable autocmds for vi when its accessed via symlink to vim

augroup csharp_syntax
au!
" c# folding
au FileType cs set omnifunc=syntaxcomplete#Complete
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}
au FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
au FileType cs set foldlevelstart=2
au FileType cs set sw=2 ts=2 noet
" Formatting, and display of improper indentation etc.,
" WARNING: isk+=. causes word boundary to include Class.name and instance.name,
" ie '.' is no longer a word boundary. This breaks tag jumping <C-]>
"au FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" cpp folding
au FileType cpp set foldmethod=syntax
au FileType cpp set sw=2 ts=2 noet

" Quickfix mode: command line msbuild error format
au FileType cs set errorformat=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m

augroup END
endif
"}}}1

