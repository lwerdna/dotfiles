function! CompileRun(timer)
	" write the file, clear terminal, run
	silent w
	silent! clear
	let l:output = system('gcc /tmp/quick.c -o /tmp/quickc')
	
	" compile succeeds, replace with output
	if empty(output)
		let l:output = system('/tmp/quickc')
	endif
		
	" switch to console window, clear, append
	call win_gotoid(g:conwin)
	normal! ggdG
	call append(0, split(l:output, '\v\n'))
	
	" switch back to source window
	call win_gotoid(g:srcwin)
endfunction

function! CompileRunTimer()
    call timer_stop(g:tctimer)
    let g:tctimer = timer_start(500, 'CompileRun')
endfunction

function! QuickCSetup()
	let g:tctimer = 0
	let g:srcwin = win_getid()

	" setup console output
	set splitright
	silent vsplit CONSOLEOUT
	setlocal buftype=nofile
	let g:conwin = win_getid()

	" switch to source window
	call win_gotoid(g:srcwin)

	" attach actions when we type
	autocmd TextChanged <buffer> call CompileRunTimer() 
	autocmd TextChangedI <buffer> call CompileRunTimer()
	call CompileRun(0)
endfunction
