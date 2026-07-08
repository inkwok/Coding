#include "extras.h"

static const char* const FILE_DESCRIPTOR = ".bf";

void
die(const char* error_message) {
    perror(error_message);
    exit(EXIT_FAILURE);
}

void
die_usage(void) {
    fprintf(stderr,
    "Usage: ./bf [FILE]... [OPTIONS]...\nExecutes brainfuck programs.\n");
    exit(EXIT_SUCCESS);
}

bool
is_brainfuck(const char* filename) {
    char* fd = strrchr(filename, '.');
    if(fd == NULL || strnlen_custom(fd , 4) > 3) return false;

    return strncmp(fd, FILE_DESCRIPTOR, 3) == 0 ? true : false;
}

size_t //std=c99 for some reason :)
strnlen_custom(const char* s, size_t maxlen) {
    size_t i;
    for(i = 0; i < maxlen && s[i] != '\0'; i++);

    return i;
}

FILE*
open_and_check(const char* filename) {
    FILE* fp = fopen(filename, "r");

    if(fp == NULL) die("fopen");
    if(is_brainfuck(filename) == false) {
        fclose(fp);
        die_usage();
    }

    return fp;
}
        // only serves up to 8 combined unix-style flags
uint8_t // i.e. ./bf program.bf -abcdefgh (fix later)
set_cmdline_flags(char* argv[]) {
    uint8_t flags = 0;
    const char* flag_string = argv[2] + 1;

    if(!argv[2] || argv[2][0] != '-') {
        flags |= ERRFLG;

        return flags;
    }

    for(uint8_t i = 0; i < strnlen_custom(flag_string, 8); i++) {
        switch(flag_string[i]) {
            case 'd': flags |= DEBUG;    break;
            case 'p': flags |= SETVBUF;  TODO("-p flag"); break;
            case 's': flags |= SHOWSYMB; TODO("-s flag"); break;
            case 'v': flags |= SETVBUF;  TODO("-v flag"); break;
            default:  flags |= ERRFLG;   break;
        }
    }

    return flags;
}
