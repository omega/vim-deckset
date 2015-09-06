noremap <silent> <buffer> <leader>R :call UpdateDecksetPreview()<CR>

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

" Should we only run when a GUI VIM is running (i.e. MacVim)
" I've seen really odd performance & glitching on CLI VIM
" when the Deckset support is running
let g:DecksetRequireGUI = 1


function! UpdateDecksetPreview()
    " todo - should we check if it's a deckset file as detected?
    if (g:DecksetRequireGUI && has("gui_running")) && g:IsDecksetRunning == 1 
      if &modified
          " Should save?
          write
      endif
      silent !clear


      let l:charPos = line2byte(search('^---$', 'bnW')) + 4
      silent let l:output = system('osascript '.s:path.'/support/update-deckset.js ' 
                  \ . shellescape(expand('%:p')) . ' '
                  \ . shellescape(l:charPos)
                  \)
      echo l:output
    endif
endfunction


augroup Deckset
    autocmd!
    " TODO - detect if this file is even open in deckset to cut 
    " down on performance issues for non-deckset editing
    autocmd BufRead,CursorMoved,InsertLeave * if &ft == "deckset" | call UpdateDecksetPreview() | endif
augroup END
