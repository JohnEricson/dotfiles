" Vim ftdetect plugin file
" Language: ProRealTime Basic	
" Maintainer:	John Ericson
" Created:	2/13/2016
" Updated:	2/13/2016
" Version: 1.0
" Project Repository: 
" Vim Script Page: 

au BufNewFile,BufRead 	*.prt 	set ft=prorealtime | runtime indent/prorealtime.vim
