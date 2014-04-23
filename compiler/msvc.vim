if(exists("current_compiler"))
	finish
endif
let current_compiler = "msvc"

"Assumes the build tool is waf

"Default error format is fine.
CompilerSet errorformat&
"CompilerSet errorformat=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m


