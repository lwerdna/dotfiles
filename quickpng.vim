function! ExecPng(timer)
	" write the file, clear terminal, run
	silent w
	silent! clear
	call system(expand('%:p'))
	call system('cat /tmp/quick.png | nc localhost 31337')
endfunction

function! ExecPngTimer()
    call timer_stop(g:tctimer)
    let g:tctimer = timer_start(500, 'ExecPng')
endfunction

function! QuickPngSetup()
	let g:tctimer = 0

	" attach actions when we type
	autocmd TextChanged <buffer> call ExecPngTimer() 
	autocmd TextChangedI <buffer> call ExecPngTimer()
	call ExecPng(0)
endfunction
