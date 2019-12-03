// +build darwin,!ios

package clipboard

/*
#cgo CFLAGS: -DGL_SILENCE_DEPRECATION -Werror -Wno-deprecated-declarations -fmodules -fobjc-arc -x objective-c

#include <stdlib.h>
#include "clipboard.h"
// #include "_cgo_export.h"
*/
import "C"

import (
	"unsafe"
)

/*
* Helpful URLs
* https://developer.apple.com/documentation/appkit/nspasteboard
* https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PasteboardGuide106/Articles/pbGettingStarted.html
* https://stackoverflow.com/questions/598587/writing-a-string-to-nspasteboard
* https://coderwall.com/p/l9jr5a/accessing-cocoa-objective-c-from-go-with-cgo
* https://developer.apple.com/documentation/foundation/nsstring/1411189-utf8string?language=objc
 */

// For Cmd-C -- copy
func Set(goString string) {
	cString := C.CString(goString)
	defer C.free(unsafe.Pointer(cString))
	C.setPasteboard(cString)
}

// For Cmd-V -- Paste
func Get() (string, bool) {
	cString := C.getPasteboard()
	if cString == nil {
		return "", false
	}
	defer C.free(unsafe.Pointer(cString))
	return C.GoString(cString), true
}
