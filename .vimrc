

" comment out lines between marks set by motion command
:function! CommentAll(...)
:   '[,'] s/^/\/\/
:endfunction


:nnoremap <leader>oc :set opfunc=CommentAll<CR>g@


"toggle true/false
:nnoremap <leader>t :execute "normal! viwy" <cr> :if getreg("\"") ==# 'true' <cr> execute "normal! viwcfalse\e" <cr> elseif getreg("\"") ==# 'false' <cr> execute "normal! viwctrue\e" <cr> endif <cr> :execute "normal! viwb\e" <cr>

