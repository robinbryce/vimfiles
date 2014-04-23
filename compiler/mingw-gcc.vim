if(exists("current_compiler"))
	finish
endif
let current_compiler = "mingw-gcc"

"Assumes the build tool is waf

set errorformat=%f:%l:%c:\ %m,%DWaf:\ Entering\ directory\ `%f',%XWaf:\ Leaving\ directory


