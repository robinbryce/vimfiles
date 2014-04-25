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
set list listchars=tab:`\ ,trail:-

set backspace=2
set splitbelow                  " edit new files in buffer below current one

" turn on line numbers
set number
" turn on syntax highlighting
syntax on
set scrolloff=99999

nmap ,s :source ~/.vimrc
nmap ,v :e ~/.vimrc

" Disable middle mouse paste - what a truly *stupid* default
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

" Don't use Ex mode, use Q for formatting
map Q gq

" Toggle line numbers with F12, makes copying cleaner
noremap <F12> :set nonumber!<CR>:set foldcolumn=0<CR>

" Run build command
map <C-F8> :make<CR>

if version >= 600
function! Fq(under, fpat, searchpat)
    "This function loads the results of a find and grep into the quickfix
    "buffer, enabling convenient jumping through the search results.
    "NOTICE: fpat is space separated, but you only get results for the first
    "pattern which getts hits, ie "*.h *.c" gives results for *.c only if no
    "matches in any *.h

    let findcall='find ' . a:under . ' '
    let patterns=split(a:fpat)
    if len(patterns) > 1
        for pat in patterns[:-2]
            let findcall = findcall . '-name "' . pat . '" -o '
        endfor
        "let findcall = findcall . '-name "' . patterns[-1] . '"'
    endif
    let findcall = findcall . '-name "' . patterns[-1] . '"' . ' -exec grep -n "' . a:searchpat . '" {} +'
    cexpr system(findcall) | copen
endfunction

function! Fqpy(under, search)
    call Fq(a:under, "*.py", a:search")
endfunction

let g:findroot=getcwd()
let g:findpat="*.*"

function! FindUnder_SetRoot()
    call inputsave()
    let g:findroot = input('findroot:', g:findroot)
    call inputrestore()
endfunction
function! FindUnder_SetPattern()
    call inputsave()
    let g:findpat = input('findpat:', g:findpat)
    call inputrestore()
endfunction

function! FindUnder()
    call inputsave()
    let what=input('what:')
    call inputrestore()
    call Fq(g:findroot, g:findpat, what)

    "let whatin=input('what in [where]:')
    "let patfpat=split(whatin)
    "permit the root to be specified as 3rd optional element
    "let fpat = input('filepat:')
    "call inputrestore()
    "let under=g:findroot
    "if len(patfpat) > 2
    "    let under=patfpat[2]
    "endif
    "call Fq(under, patfpat[1], patfpat[0])

endfunction

map <C-f> :call FindUnder() <CR>
map <C-f>p :call FindUnder_SetPattern() <CR>
map <C-f>r :call FindUnder_SetRoot() <CR>
endif

if version >= 600
    "filetype on
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

if version >= 500
autocmd!
         "Remove ALL autocommands for the current group, so we can source
         ".vimrc multiple times.

"effectively, disable autocmds for vi when its accessed via symlink to vim

" c# folding
au FileType cs set omnifunc=syntaxcomplete#Complete
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}
au FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
au FileType cs set foldlevelstart=2
au FileType cs set sw=2 ts=2 noet
" Formatting, and display of improper indentation etc.,
au FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" cpp folding
au FileType cpp set foldmethod=syntax
au FileType cpp set sw=2 ts=2 noet

" Quickfix mode: command line msbuild error format
au FileType cs set errorformat=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m
endif

" With the following setting, Vim will search for the file named 'tags',
" starting with the directory of the current file and then going to the parent
" directory and then recursively to the directory one level above, till it
" either locates the 'tags' file or reaches the root directory
set tags=./tags;

