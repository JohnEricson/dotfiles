" Vim indent file
" Language: ProRealTime Basic	
" Author:	John Ericson
" Last Change:	2/13/2016
"		Based on vb.vim.

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=PrtGetIndent(v:lnum)
setlocal indentkeys&
setlocal indentkeys+==~else,=~elsif,=~endif,=~wend,=~case,=~next,=~select,=~loop,<:>

let b:undo_indent = "set ai< indentexpr< indentkeys<"

" Only define the function once.
if exists("*PrtGetIndent")
    finish
endif

fun! PrtGetIndent(lnum)
    " labels and preprocessor get zero indent immediately
    let this_line = getline(a:lnum)
    let LABELS_OR_PREPROC = '^\s*\(\<\k\+\>:\s*$\|#.*\)'
    if this_line =~? LABELS_OR_PREPROC
	return 0
    endif

    " Find a non-blank line above the current line.
    " Skip over labels and preprocessor directives.
    let lnum = a:lnum
    while lnum > 0
	let lnum = prevnonblank(lnum - 1)
	let previous_line = getline(lnum)
	if previous_line !~? LABELS_OR_PREPROC
	    break
	endif
    endwhile

    " Hit the start of the file, use zero indent.
    if lnum == 0
	return 0
    endif

    let ind = indent(lnum)

    " Add
    if previous_line =~? '^\s*\<\(begin\|\%(\%(private\|public\|friend\)\s\+\)\=\%(function\|sub\|property\)\|select\|case\|default\|if\|else\|elsif\|do\|for\|while\|enum\|with\)\>'
	
	" if comment then skip.
	if previous_line =~? '\s*\/\/'
	else
	    let ind = ind + &sw
	endif
	
    endif

    " Subtract
    if this_line =~? '^\s*\<endif\>\s\+\<select\>'
	if previous_line !~? '^\s*\<select\>'
	    let ind = ind - 2 * &sw
	else
	    " this case is for an empty 'select' -- 'end select'
	    " (w/o any case statements) like:
	    "
	    " select case readwrite
	    " end select
	    let ind = ind - &sw
	endif
    elseif this_line =~? '^\s*\<\(endif\|else\|elsif\|until\|loop\|next\|wend\)\>'
	let ind = ind - &sw
    elseif this_line =~? '^\s*\<\(case\|default\)\>'
	if previous_line !~? '^\s*\<select\>'
	    let ind = ind - &sw
	endif
    endif

    return ind
endfun

" vim:sw=4 ts=8
