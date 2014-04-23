function! Fcd_bufferdir()
let _dir = expand("%:p:h")
exec "cd " . _dir
unlet _dir
endfunction
"autocmd BufEnter * call Fcd_bufferdir()


