/*
 * JavaScript for Mac Automation of Deckset.app 
 *    (what do you call JavaScript used like Applescript?)
 *
 *    http://github.com/bwmcadams/vim-deckset
 *    Author: Brendan McAdams <brendan@evilmonkeylabs.com>
 *    
 *    Based upon http://github.com/omega/vim-deckset
 *
 * When called with appropriate arguments, updates the preview window &
 * main Deckset view for a given slide deck to the appropriate slide for 
 * whatever 'position' corresponds to in 'filePath'
 * 
 * Arguments:
 *    filePath - a String containing the path + filename of the Markdown file for the slide deck
 *    position - an Integer containing the position (line number?) in the slide deck to update view to
 */ 

ObjC.import('stdlib')
ObjC.import('AppKit')

function run(argv) {
  var filePath = argv[0]
  var position = argv[1]


  deckset = Application('Deckset')
  deckset.includeStandardAdditions = true
  
  // This is terrible code but my javascript-fu is weak these days
  if (typeof filePath === 'undefined') {

    console.log("Invalid use of VIM Deckset: Must provide path of markdown file being edited.")

  } else if (typeof position === 'undefined') {

    console.log("Invalid use of VIM Deckset: Must provide current position in markdown file.")

  } else {
    
    /* turn on preview window. 
     * You may want to comment this out if it
     * isn't to your preference
     */
    deckset.preview = true


    var files = deckset.documents.whose({ file: filePath })
    
    if (files.length != 1) {
      $.exit(0)
    } else {
      files[0].position = position

      $.exit(1)
    }
  }
}
