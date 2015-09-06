let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! IsDecksetFile()
    if has("gui_running")
      let l:output = system('osascript '.s:path.'/support/is-deckset-file.js '.shellescape(expand('%:p')))


			if v:shell_error == 1
        " So we only skim the app runthrough once per vim session
        " Many markdown implementations want 4 space tabs
				set filetype=deckset sw=4 ts=4
        let g:IsDecksetRunning = 1
        let g:IsDecksetOpenFile = 1
      elseif v:shell_error == 0
        let g:IsDecksetRunning = 1
        let g:IsDecksetOpenFile = 0
      else 
        let g:IsDecksetRunning = 0
			endif

    endif
endfunction


au! BufRead,BufNewFile *  if &ft == ("markdown" || "ghmarkdown")  | call IsDecksetFile() | endif

"set filetype=deckset ts=4 sw=4

