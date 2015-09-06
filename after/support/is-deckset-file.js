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
 * Checks if a markdown file is open in Deckset, so we can decide
 * if we set the filetype to Deckset and run the preview update
 * or set it to standard Markdown
 *
 * Arguments:
 *    filePath - a String containing the path + filename of the Markdown file for the slide deck (we'll check if it's a slide deck rather.
 */ 

// Look for a running instance of Deckset
ObjC.import('stdlib')
ObjC.import('AppKit')

var isRunning = false

var apps = $.NSWorkspace.sharedWorkspace.runningApplications // Note these never take () unless they have arguments

apps = ObjC.unwrap(apps) // Unwrap the NSArray instance to a normal JS array

var app, deckset

for (var i = 0, j = apps.length; i < j; i++) {
  app = apps[i]

  // Another option for comparison is to unwrap app.bundleIdentifier
  // ObjC.unwrap(app.bundleIdentifier) === 'org.whatever.Name'

  // Some applications do not have a bundleIdentifier as an NSString
  if (typeof app.bundleIdentifier.isEqualToString === 'undefined') {
    continue
  }

  if (app.bundleIdentifier.isEqualToString('com.unsignedinteger.Deckset')) {
    isRunning = true
    break
  }
}

if (!isRunning) {
  $.exit(-1)
}

deckset = Application('Deckset')

function run(argv) {
  var filePath = argv[0]

  deckset.includeStandardAdditions = true
  
  // This is terrible code but my javascript-fu is weak these days
  if (typeof filePath === 'undefined') {
		$.exit(0)
  } else {  
    
    var documents = deckset.documents

    var files = deckset.documents.whose({ file: filePath })

		if (files.length != 1) {    
			/* turn off preview window if we aren't editing
			 * a deckset file.
			 * You may want to comment this out if it
			 * isn't to your preference.
			 * TODO: VIM Setting for this.
			 */
			deckset.preview = false
		}

		$.exit(files.length)
  }
}

