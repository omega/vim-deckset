noremap <silent> <buffer> <leader>R :call UpdateDecksetPreview()<CR>

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! UpdateDecksetPreview()
    if has("gui_running")
      if &modified
          " Should save?
          write
      endif
      silent !clear


      let l:position = line2byte(line("."))
      let l:output = system('osascript '.s:path.'/support/call-deckset.scpt ' 
                  \ . shellescape(expand('%:p')) . ' '
                  \ . shellescape(l:position)
                  \)
      echo l:output
    endif
endfunction


augroup Deckset
    autocmd!
    autocmd CursorMoved,InsertLeave *.md :call UpdateDecksetPreview()
augroup END
