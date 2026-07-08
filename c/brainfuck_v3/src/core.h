#ifndef CORE_H
#define CORE_H
#include <stdint.h>

#define MAX_WORD  UINT32_MAX

#define IBOUND (p >= program.size || memory.p >= memory.size ||\
                p >  MAX_WORD     || memory.p >  MAX_WORD)
#define PBOUND (p >= program.size || stack.p >= stack.size ||\
                p >  MAX_WORD     || stack.p >  MAX_WORD)

typedef uint32_t WORD;
typedef uint64_t DWORD;

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

int
run(const prog_t program, const uint8_t flags);

prog_t
cook(const char* filename, const uint8_t flags);

#endif /* CORE_H */
