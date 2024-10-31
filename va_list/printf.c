#include <stdarg.h>

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
    // do something ...
}

void printf(const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  vprintf(1, fmt, ap);
}

