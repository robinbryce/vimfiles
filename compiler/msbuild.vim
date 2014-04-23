if(exists("current_compiler"))
    finish
endif
let current_compiler = "msbuild"

CompilerSet errorformat=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m


