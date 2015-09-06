# vim-deckset

_Originally based upon [omega/vim-deckset](https://github.com/omega/vim-deckset) but mostly rewritten_ 

[Deckset](http://decksetapp.com) is an OS X application for rendering markdown 
as presentation.

It has a nifty floating preview window that shows up in edit mode, and by default
updates the view when the markdown file is saved. By default it makes a best guess 
as to what the last modified section is, and tries to update the preview to that 
slide.

It turns out however, that Deckset's preview window can be scripted using AppleScript and JavaScript Automation. 

For us [Vim](http://www.vim.org) users, we can do a bit better than
the default behavior. This Vim plugin will, under the right
circumstances, update the contents of the preview window 
__as you move your VIM cursor__ around in the Markdown file.

In order to avoid conflicting with your existing Markdown plugins & syntax
detectors when you _are not_ running Deckset, the plugin takes a few extra 
safety steps.

- It checks both if Deckset is running, and the file you're editing is _open inside of Deckset_.
- If these conditions are met, your Vim filetype is set to ‘deckset’. 
- Apart from the syntax highlighting files, this plugin should be run out of the `.vim/after` folders, so that it makes sure to pick up and set the ‘deckset’ filetype without it later being overridden by other Markdown detectors (assuming those aren't _also_ loaded in `after`).
    
In addition, there's an enhanced Vim syntax file based on [jratner/vim-flavored-markdown](https://github.com/jtratner/vim-flavored-markdown), which adds more Deckset awareness on top of Github Flavored Markdown support.
    
I've seen issues with terminal based Vim acting odd & glitchy when the plugin is activated. As a result, by default I have the plugin set to only execute only when the GUI mode (aka MacVim) is running. If you'd like to change it you can set the following in your `.vimrc` file:

```vim
let g:DecksetRequireGUI = 0
```
    
In order to not totally overload your Vim session by running everytime you
move through the file, `vim-deckset` updates the preview window on the following conditions:

- CursorHold – In Command mode, if the Cursor hasn't moved in `g:DecksetPreviewPauseTime` milliseconds
- CursorHoldI - In Insert mode, if the Cursor hasn't moved in `g:DecksetPreviewPauseTime` milliseconds
- BufRead - The file is read from disk (such as when we first open)
- BufWrite - When the file is saved
- FocusGained - The Vim window is brought to the foreground
- InsertLeave - Insert mode is exited

The default for `g:DecksetPreviewPauseTime` is 500 milliseconds. You can
change that by setting a new value (in milliseconds) in your
`.vimrc`:


```vim
let g:DecksetPreviewPauseTime = 750
```

Additionally, `vim-deckset` is set to automatically save the file if any of the
above conditions trigger & the file buffer is modified. If you'd like to
disable that behavior, you can turn it off in your `.vimrc`:

```vim
let g:DecksetAutosave = 0
```

Finally, if you'd like to force an update to the Deckset Preview window, you
can either run:

```vim
:call UpdateDecksetPreview()
```

Or, if `<leader>` is set, `<leader>R`.
