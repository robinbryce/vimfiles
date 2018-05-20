"sECREt sauce
"
" Insert space around 'word'
" Insert quotes around 'word'

" TAG, NAVIGATION & Static Analisys
" toggle scroll offset between 0 or 999
" toggle auto line breaks
""""

"minibufexpl options


" YouCompleteMe options
let g:ycm_collect_identifiers_from_tags_files = 1

noremap <F3> "zyiw:vimgrep <C-R>z **/*.py
noremap <F4> :buffers<cr>

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


noremap <leader>ffi :YcmCompleter FixIt<cr>
noremap <leader>g :GitGutterLineHighlightsToggle<cr>
" Toggle line numbers with <leader>nn, makes copying cleaner
noremap <leader>nn :set nonumber!<CR>:set foldcolumn=0<CR>
" Don't use Ex mode, use Q for formatting
map Q gq


set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Display of state of things.
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Navigation
Plugin 'scrooloose/nerdtree'
Plugin 'Konfekt/FastFold'
Plugin 'majutsushi/tagbar'

" Finding things, including completions
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mileszs/ack.vim'

" Environments
Plugin 'plytophogy/vim-virtualenv'

" Building things
Plugin 'vim-syntastic/syntastic'
Plugin 'fatih/vim-go'


call vundle#end()
filetype plugin indent on

" Plugins to disable.
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

" GUI OPTIONS
set guioptions-=T "remove gui tool bar.

" STATUS LINE - vim-airline
let g:airline#extentions#tabline#enabled = 1
"set statusline+=...[%{&fo}]...

"SYNTASTIC
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%{virtualenv#statusline()}
"set statusline+=%*
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

"Only populate location list when :Errors is run
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_python_exec = '~/pyenvs/pydev/bin/python3'
let g:syntastic_python_pylint_exec = '~/pyenvs/pydev/bin/pylint'
" Note: python path can be manipulated in pylintrc
let g:syntastic_python_pylint_args = '--rcfile=~/pyenvs/pydev/pylintrc'

let g:syntastic_python_checkers = ['pylint']



" tags {{{1
" With the following setting, Vim will search for the file named 'tags',
" starting with the directory of the current file and then going to the parent
" directory and then recursively to the directory one level above, till it
" either locates the 'tags' file or reaches the root directory
set tags=./tags;
"}}}1

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
