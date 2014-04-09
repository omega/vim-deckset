noremap <silent> <buffer> <leader>R :call UpdateDecksetPreview()<CR>

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
echo s:path

function! UpdateDecksetPreview()
    if &modified
        " Should save?
        write
    endif
    silent !clear

    let l:position = line2byte(line("."))
    echo l:position
    let l:output = system('osascript '.s:path.'/support/call-deckset.scpt ' 
                \ . shellescape(expand('%:p')) . ' '
                \ . shellescape(l:position)
                \)
    echo l:output
endfunction


augroup Deckset
    autocmd!
    autocmd CursorMoved,InsertLeave *.md :call UpdateDecksetPreview()
augroup END
