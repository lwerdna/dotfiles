function! ExecGnuplot(timer)
	" write the file, clear terminal, run
	silent w
	silent! clear
	call system('gnuplot /tmp/quick.gplt | nc localhost 31337')
endfunction

function! ExecGnuplotTimer()
    call timer_stop(g:tctimer)
    let g:tctimer = timer_start(500, 'ExecGnuplot')
endfunction

function! QuickGnuplotSetup()
	let g:tctimer = 0

	" attach actions when we type
	autocmd TextChanged <buffer> call ExecGnuplotTimer() 
	autocmd TextChangedI <buffer> call ExecGnuplotTimer()
	call ExecGnuplot(0)
endfunction
