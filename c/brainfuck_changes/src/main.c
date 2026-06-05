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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#define MAX_WORD  UINT32_MAX

#define TODO(MSG) \
    do { \
        fprintf(stderr,\
            "TODO: %s\ncrashed at %s:%d\n", MSG, __FILE__, __LINE__); \
        abort(); \
    } while(0);

typedef uint32_t WORD;
typedef uint64_t DWORD;

static const char* const FILE_DESCRIPTOR = ".bf";
static const char* const DBG_TEXT = "\n\x1b[1;32mMemory size: %lu Kib\x1b[0m\n";
static const char* const FDBG_TEXT = "\x1b[1;32mMemory size: %lu Kib\x1b[0m\n";

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

typedef enum {
    TOK_NULL,
    TOK_IN,   TOK_OUT,
    TOK_ADD,  TOK_SUB,
    TOK_LEFT, TOK_RIGHT,
    TOK_JZ,   TOK_JNZ
} token_t;

typedef struct {
    token_t token;
    WORD argument;
} inst_t;

typedef struct {
    inst_t* tape;
    DWORD size;
    uint8_t cflags;
    uint8_t rflags;
} prog_t;

typedef struct {
    WORD* tape;
    DWORD size, p;
} mem_t;

static size_t //std=c99 for some reason :)
strnlen_custom(const char* s, size_t maxlen) {
    size_t i;
    for(i = 0; i < maxlen && s[i] != '\0'; i++);

    return i;
}

static void
die(const char* error_message) {
    perror(error_message);
    exit(EXIT_FAILURE);
}

static void
die_usage(void) {
    fprintf(stderr,
    "Usage: ./bf [FILE]... [OPTIONS]...\nExecutes brainfuck programs.\n");
    exit(EXIT_SUCCESS);
}

static bool
is_brainfuck(const char* filename) {
    char* fd = strrchr(filename, '.');
    if(fd == NULL || strnlen_custom(fd , 4) > 3) return false;

    return strncmp(fd, FILE_DESCRIPTOR, 3) == 0 ? true : false;
}
               // only serves up to 8 combined unix-style flags
static uint8_t // i.e. ./bf program.bf -abcdefgh (fix later)
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

static FILE*
open_and_check(const char* filename) {
    FILE* fp = fopen(filename, "r");

    if(fp == NULL) die("fopen");
    if(is_brainfuck(filename) == false) {
        fclose(fp);
        die_usage();
    }

    return fp;
}

static mem_t
init_stack(void) {
    mem_t s = {
        .tape = malloc(256 * sizeof(WORD)),
        .size = 256,
        .p = 0,
    };

    return s;
}

static prog_t
init_program(void) {
    prog_t p = {
        .tape = malloc(256 * sizeof(inst_t)),
        .size = 256,
        .cflags = 0,
        .rflags = 0,
    };

    return p;
}

static mem_t
init_memory(void) {
    mem_t m = {
        .tape = calloc(256, sizeof(WORD)),
        .size = 256,
        .p = 0,
    };

    return m;
}

static inline int
ensure_size(prog_t* p, mem_t* s, mem_t* m, const uint8_t flags) {
    if(p && p->tape && !(p->tape = realloc(p->tape, (p->size *= 2) *
        sizeof(inst_t))))
        return EXIT_FAILURE;
    if(s && s->tape && !(s->tape = realloc(s->tape, (s->size *= 2) *
        sizeof(WORD))))
        return EXIT_FAILURE;
    if(m && m->tape) {
        if(!(m->tape = realloc(m->tape, (m->size *= 2) * sizeof(WORD))))
            return EXIT_FAILURE;
        for(DWORD i = m->p; i < m->size; i++) m->tape[i] = 0;
        if(flags & DEBUG) printf(DBG_TEXT, m->size * sizeof(WORD) / 1024);
    }

    return EXIT_SUCCESS;
}

static int
interpret(const prog_t program, DWORD* p, mem_t* memory, const uint8_t f) {
    switch(program.tape[*p].token) {

        case TOK_IN:    (void)scanf("%u", &memory->tape[memory->p]); break;
        case TOK_OUT:   putchar((int)memory->tape[memory->p]);           break;
        case TOK_ADD:   memory->tape[memory->p]++;                       break;
        case TOK_SUB:   memory->tape[memory->p]--;                       break;
        case TOK_RIGHT: memory->p++;                                     break;
        case TOK_LEFT:  memory->p--;                                     break;
        case TOK_JZ:    if(!memory->tape[memory->p])
                            *p = program.tape[*p].argument;
                                                                         break;
        case TOK_JNZ:   if(memory->tape[memory->p])
                            *p = program.tape[*p].argument;
                                                                         break;
        default:        return EXIT_FAILURE;
    }
    (*p)++;
    
    if((memory->p == memory->size &&
        ensure_size(NULL, NULL, memory, f))) 
        return EXIT_FAILURE;

    return EXIT_SUCCESS;
}


static int
run(const prog_t program, const uint8_t flags) {
    mem_t memory = init_memory();
    DWORD p = 0;
    bool interpret_bounds = (p >= program.size || memory.p >= memory.size ||
                             p >  MAX_WORD     || memory.p >  MAX_WORD);

    if(!memory.tape) return EXIT_FAILURE;
    if(flags & DEBUG) printf(FDBG_TEXT, memory.size * sizeof(WORD) / 1024);

    while(!(program.tape[p].token == TOK_NULL || interpret_bounds))
        if(interpret(program, &p, &memory, flags) == EXIT_FAILURE) break;

    if(program.tape[p].token != TOK_NULL || interpret_bounds) {
        if(memory.tape) free(memory.tape); //do error handling here
        return EXIT_FAILURE;
    }

    if(memory.tape) free(memory.tape);

    return EXIT_SUCCESS;
}

static inline void
append(prog_t* self, DWORD* p, const token_t t) {
    self->tape[*p].token = t;
}

static inline void
push(mem_t* self, DWORD* p) {
    self->tape[self->p++] = *p;
}

static inline DWORD
pop(mem_t* self) {
    return self->tape[--self->p];
}

static inline int
parse(prog_t* program, mem_t* stack, DWORD* p, const char c) {
    switch(c) {
        case ',': append(program, p, TOK_IN);      break;
        case '.': append(program, p, TOK_OUT);     break;
        case '+': append(program, p, TOK_ADD);     break;
        case '-': append(program, p, TOK_SUB);     break;
        case '<': append(program, p, TOK_LEFT);    break;
        case '>': append(program, p, TOK_RIGHT);   break;
        case '[': append(program, p, TOK_JZ);
                  push(stack, p);                  break;
        case ']': append(program, p, TOK_JNZ);
                  if(stack->p == 0) {
                      stack->p++;
                      return EXIT_FAILURE;
                  }
                  DWORD jp = pop(stack);
                  program->tape[*p].argument = jp;
                  program->tape[jp].argument = *p; break;
        default: (*p)--;
    }
    (*p)++;

    if(*p == program->size && ensure_size(program, NULL, NULL, 0))
        return EXIT_FAILURE;
    if(stack->p == stack->size && ensure_size(NULL, stack, NULL, 0))
        return EXIT_FAILURE;
    return EXIT_SUCCESS;
}


static prog_t 
cook(const char* filename, const uint8_t flags) {
    char c = 0;
    DWORD p = 0;
    prog_t program = init_program();
    mem_t stack = init_stack();
    FILE* fp = open_and_check(filename);

    bool parse_bounds = (p >= program.size || stack.p >= stack.size ||
                         p >  MAX_WORD     || stack.p >  MAX_WORD);
    if(!program.tape || !stack.tape) { // may err here
        if(program.tape) free(program.tape);
        if(stack.tape) free(stack.tape);
    }

    while(!(c == EOF || parse_bounds) && program.tape) {
        c = fgetc(fp);
        if(parse(&program, &stack, &p, c) == EXIT_FAILURE) {
            program.cflags |= C_ERRPRS;
            break;
        }
    }

    if(c != EOF || stack.p != 0 || parse_bounds) {
        if(program.tape) free(program.tape);
        if(stack.tape) free(stack.tape);
        program.size = 0;
        program.cflags |= C_ERRBND;
    }

    if(program.tape) program.tape[p].token = TOK_NULL;
    fclose(fp);

    return program;
}

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
