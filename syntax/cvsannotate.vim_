syn clear

syn match       cvsannRevision  "^\d\+\.\d\+\(\.\d\+\.\d\+\)\=" contained
syn match       cvsannUser      "(\S\+"hs=s+1 contained
syn match       cvsannDate      "\S\+)"he=e-1 contained

syn region      cvsannPrologue  start="^" end=":" contains=cvsannRevision,cvsannUser,cvsannDate 

syn sync minlines=1

if !exists("did_cvsann_syntax_inits")
  let did_cvsann_syntax_inits = 1
  " OK. Let's make this colourful.
  hi link cvsannRevision        Constant
  hi link cvsannUser            Statement
  hi link cvsannDate            PreProc

  hi link cvsannPrologue        Identifier
endif   
