// +build darwin,!ios

@import AppKit;

#include "clipboard.h"
// #include "_cgo_export.h"

// Both of the below functions were adapted from
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PasteboardGuide106/Articles/pbGettingStarted.html
// which is actually about copying and pasting *images*, so whether this is the
// best way to do this, I don't know.

// "copy" -- write to the pasteboard
void setPasteboard(const char *cString) {
	// Get the passed string as an NSString
	NSString *string = [NSString stringWithUTF8String:cString];

	// Get the default pasteboard object
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];

	// Clear the current contents
	[pasteboard clearContents];

	// Make an array out of our string
	NSArray *copiedObjects = [NSArray arrayWithObject:string];

	// Write the array into the pasteboard
	[pasteboard writeObjects:copiedObjects];
}

// "paste" -- read from the pasteboard
const char *getPasteboard() {
	// Get the default pasteboard object
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];

	// Create an empty array of NSStrings, and an empty dictionary
	NSArray *classArray = [NSArray arrayWithObject:[NSString class]];
	NSDictionary *options = [NSDictionary dictionary];
 
	// See if we can read strings out of the current pasteboard
	BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
	if (ok) {
		// Actually copy strings out of the pasteboard
		NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];

		// Get item 0
		NSString *stringObj = [objectsToPaste objectAtIndex:0];

		// Get a pointer to the UTF8-encoded C-string, which is an internal field
		// of stringObj.
		const char *s = [stringObj UTF8String];

		// stringObj may be freed at any point, so copy it into malloced memory,
		// and free it in the caller.
		char *ms = malloc(strlen(s)+1); // Allow space for null-terminator!
		if (ms == NULL) {
			return nil;
		}

		// Copy the string and return it
		strcpy(ms, s);
		return ms;
	}

	// There are no strings in the pasteboard
	return nil;
}

