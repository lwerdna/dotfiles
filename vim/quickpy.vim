function! ExecPy(timer)
	" write the file, clear terminal, run
	silent w
	silent! clear
	let l:output = system('python /tmp/quick.py')
	
	" switch to console window, clear, append
	call win_gotoid(g:conwin)
	normal! ggdG
	call append(0, split(l:output, '\v\n'))
	
	" switch back to source window
	call win_gotoid(g:srcwin)
endfunction

function! ExecPyTimer()
    call timer_stop(g:tctimer)
    let g:tctimer = timer_start(500, 'ExecPy')
endfunction

function! QuickPySetup()
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
	autocmd TextChanged <buffer> call ExecPyTimer() 
	autocmd TextChangedI <buffer> call ExecPyTimer()
	call ExecPy(0)
endfunction
