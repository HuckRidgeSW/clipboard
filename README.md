# clipboard
Access to the Mac clipboard (which it calls a pasteboard) in Go, using native
APIs, not pbcopy/pbpaste.

The Mac pasteboard stores items with a type (string, image, url, etc).  This
library currently reads & writes only strings.

# Import

```go
import 	"github.com/huckridgesw/clipboard"
```

# Copy & Paste

```go
// write a string to the pasteboard -- "copy"
clipboard.Set("a string")

// read a string from the pasteboard -- "paste"
if s, ok := clipboard.Get(); ok {
  // do something with s
}
```

`Get` will only fail (return with `ok` == `false`) if there are no strings in
the pasteboard, or your program runs out of memory and `malloc` returns `NULL`.
