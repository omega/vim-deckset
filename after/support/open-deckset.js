/*
 * JavaScript for Mac Automation of Deckset.app 
 *    (what do you call JavaScript used like Applescript?)
 *
 *    http://github.com/bwmcadams/vim-deckset
 *    Author: Brendan McAdams <brendan@evilmonkeylabs.com>
 *    
 *    Based upon http://github.com/omega/vim-deckset
 *
 *
 * Toggles open Deckset, and opens the given file in it.
 *
 * Arguments:
 *    filePath - a String containing the path + filename of the Markdown file for the slide deck (we'll check if it's a slide deck rather.
 */ 

// Look for a running instance of Deckset
ObjC.import('stdlib')
ObjC.import('AppKit')


function run(argv) {
  var filePath = argv[0]

  var deckset = Application("Deckset")
  deckset.includeStandardAdditions = true
  
  // This is terrible code but my javascript-fu is weak these days
  if (typeof filePath === 'undefined') {
    console.log("WARNING: No file specified.")
    $.exit(0)
  } else {  
    deckset.open(Path(filePath))

    $.exit(1)
  }
}
