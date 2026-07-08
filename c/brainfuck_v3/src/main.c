//  TODO: handle flags, errors
//
//  completes e benchmark
//
//  handle flags:
//      implement SETVBUF
//      implement verbose output/debug output
//  errors:
// 1. too many '[' symbols
// 2. too many ']' symbols
// 3. file does not exist
#include "extras.h"
#include "core.h"

int
main(int argc, char* argv[]) {
    uint8_t flags = 0;
    prog_t program;

    if(argc < 2) die_usage();
    if(argc > 2) flags = set_cmdline_flags(argv);

    program = cook(argv[1], flags);
    if(!program.size) return EXIT_FAILURE; // inspect .cflags
    run(program, flags); // inspect .rflags

    free(program.tape);

    return flags & STATUS;
}
