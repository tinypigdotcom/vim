" Active Server Pages (with Perl or Visual Basic Script)
au BufNewFile,BufRead *.asp
	\   setf perl |
"
" Povray, PHP or assembly
au BufNewFile,BufRead *.inc			call s:FTinc()

func! s:FTinc()
  if exists("g:filetype_inc")
    exe "setf " . g:filetype_inc
  else
    let lines = getline(1).getline(2).getline(3)
      setf perl
"      setf aspperl
  endif
endfunc

