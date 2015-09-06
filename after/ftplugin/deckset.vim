noremap <silent> <buffer> <leader>R :call s:UpdateDecksetPreview()<CR>
command! -nargs=0 -bar DecksetUpdate call s:UpdateDecksetPreview()

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')


" Pause on CursorHold before update, in milliseconds
if !exists('g:DecksetPreviewPauseTime')
  let g:DecksetPreviewPauseTime = 500
endif

" Automatically save on update if buffer modified?
if !exists('g:DecksetAutosave')
  let g:DecksetAutosave = 1
endif

function! s:UpdateDecksetPreview()
    " todo - should we check if it's a deckset file as detected?
    if (!g:DecksetRequireGUI || has("gui_running")) && g:IsDecksetRunning == 1 
      if &modified && g:DecksetAutosave
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
   " adjust me for CursorHold Tweaks
   execute "set updatetime=".g:DecksetPreviewPauseTime
   autocmd CursorHold,CursorHoldI,BufRead,BufWrite,FocusGained,InsertLeave  * if &ft == "deckset" | call s:UpdateDecksetPreview() | endif
    
augroup END
