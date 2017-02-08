nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    execute 'AsyncRun grep -nH -R ' .
        \  '--exclude-dir=.{stack-work} ' .
        \  shellescape(expand("<cWORD>")) .
        \  " ."
    copen

    let @@ = saved_unamed_register
endfunction
