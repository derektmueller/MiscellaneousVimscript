
"https://github.com/parenparen/
"
"Copyright 2014 Derek Mueller
"Released under the MIT license
"http://opensource.org/licenses/MIT


:function! CopyFnToClipboard ()

"save original location
:   execute "normal! m'" 

:   let l:ln1 = line ('.')
:   let l:ln2 = search ('function')

"detect whether cursor is inside a function or on the first line of a
"function definition
:   if (l:ln1 ==# l:ln2) 
        "set mark on current line, move to end of 
        "function, end copy
:       execute "normal! maf{%\"+y'a"
:   else
        "move to beginning of function, set mark, move to end of 
        "function, end copy
:       execute "normal! `'?function\rmaf{%\"+y'a" 
:   endif
:
:endfunction

:function! CommentFn ()

"save original location
:   execute "normal! m'" 

:   let l:ln1 = line ('.')
:   let l:ln2 = search ('function')

"detect whether cursor is inside a function or on the first line of a
"function definition
:   if (l:ln1 ==# l:ln2) 
:       "start comment on current line and move to end of function
:       execute "normal! I/*\ef{%A*/\e"
:   else
        "move to beginning of function, start comment, move to end of 
        "function, end comment 
:       execute "normal! `'?function\rI/*\ef{%A*/\e" 
:   endif
:
:endfunction

"like CommentFn except comment start and end are removed
:function! UncommentFn ()
:   execute "normal! m'" 
:   let l:ln1 = line ('.')
:   let l:ln2 = search ('function')
:   if (l:ln1 ==# l:ln2) 
:       execute "normal! 0xxf{%$xx"
:   else
:       execute "normal! `'?function\r0xxf{%$xx" 
:   endif
:
:endfunction

" comment out lines between marks set by motion command
:function! CommentAll (...)
:   let l:ft = &filetype
:   if l:ft ==# 'vim'
:       '[,'] s/^/"/
:   elseif l:ft =~# 'python\|perl'
:       '[,'] s/^/#/
:   else
:       '[,'] s/^/\/\/
:   endif
:endfunction

:function! UncommentAll (...)
:   let l:ft = &filetype
:   if l:ft ==# 'vim'
:       '[,'] s/"//
:   elseif l:ft =~# 'python\|perl'
:       '[,'] s/#//
:   else
:       '[,'] s/^\/\//
:   endif
:endfunction


:nnoremap <leader>oc :set opfunc=CommentAll<CR>g@
:nnoremap <leader>ouc :set opfunc=UncommentAll<CR>g@


"toggle true/false
:nnoremap <leader>t :execute "normal! viwy" <cr> :if getreg("\"") ==# 'true' <cr> execute "normal! viwcfalse\e" <cr> elseif getreg("\"") ==# 'false' <cr> execute "normal! viwctrue\e" <cr> endif <cr> :execute "normal! viwb\e" <cr>


:augroup filetypeJS
:   autocmd!
:   autocmd FileType javascript :nnoremap <buffer> <localleader>cf :call CommentFn ()<cr>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>Cf :call CopyFnToClipboard ()<cr>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>uf :call UncommentFn ()<cr>

:augroup END
