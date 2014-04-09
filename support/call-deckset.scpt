on run argv
    set fp to item 1 of argv
    set pos to item 2 of argv
    if application "Deckset" is running
        tell application "Deckset"
            set seen to false
            repeat with doc in documents
                if file of doc is equal to fp as POSIX file then
                    set seen to doc
                end if
            end repeat
            # If we do this, we open a dockset document for every markdown file we edit..
            #if seen is false then
            #    set seen to open fp as POSIX file
            #end if
            if seen is not false then
                set position of seen to pos
            end if
        end tell
    end if
end run

