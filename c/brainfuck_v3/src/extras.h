#ifndef EXTRAS_H
#define EXTRAS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#define TODO(MSG) {{                         \
        fprintf(stderr,                      \
            "TODO: %s\ncrashed at %s:%d\n",  \
            MSG, __FILE__, __LINE__);        \
        abort();                             \
}}

/*
static const char* const SYMBOL_TABLE[] = {
    "NULL",
    "IN",   "OUT",
    "ADD",  "SUB",
    "LEFT", "RIGHT",
    "JZ",   "JNZ",
};
*/

enum {                 // cmdline flag options
    STATUS   = 1 << 0, // retval
    DEBUG    = 1 << 1, // show memory information
    SHOWSYMB = 1 << 2, // show symbols
    SETVBUF  = 1 << 3, // different printf() behavior
    ERRFLG   = 1 << 7, // error parsing cmdline flag chars
};

enum {
    C_STATUS = 1 << 0, // retval
    C_ERRPRS = 1 << 1, // malloc() failed in ensure_size() in parse() in cook()
    C_ERRBND = 1 << 2, // bounds check failed after cook completion
};

enum {
    R_STATUS = 1 << 0, //retval
    R_ERRPRS = 1 << 1, // malloc() failed in ensure_size()
    R_ERRBND = 1 << 2, // bounds check failed
};

void
die(const char* error_message);

void
die_usage(void);

bool
is_brainfuck(const char* filename);

size_t
strnlen_custom(const char* s, size_t maxlen);

FILE*
open_and_check(const char* filename);

uint8_t
set_cmdline_flags(char* argv[]);

#endif /* EXTRAS_H */
