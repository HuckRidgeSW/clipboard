#ifndef _CLIPBOARD_H
#define _CLIPBOARD_H

__attribute__ ((visibility ("hidden"))) void setPasteboard(const char *string);
__attribute__ ((visibility ("hidden"))) const char *getPasteboard();

#endif
