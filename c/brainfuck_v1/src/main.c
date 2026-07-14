// Inspired by https://github.com/kgabis/brainfuck-c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <limits.h>
#include <stdint.h>

#define MAX_WORD UINT32_MAX

#define APPEND(T) program->array[program->p].token = T;

#define PUSH(P) stack->array[stack->p++] = P;
#define POP() stack->array[--stack->p];

typedef uint32_t word;
typedef uint64_t dword;

const char* FILE_EXTENSION = ".bf";
const char* DIE_TEXT =
    "Usage: %s [FILE]... [OPTIONS]...\nExecutes brainfuck programs.\n";
const char* DBG_TEXT = "\n\x1b[1;32mMemory size: %lu KiB\x1b[0m\n";
const char* FDBG_TEXT = "\x1b[1;32mMemory size: %lu KiB\x1b[0m\n";

typedef enum token_kind
{
    tok_null,
    tok_in, tok_out, tok_add, tok_sub,
    tok_left, tok_right, tok_jz, tok_jnz
} Token_k;

typedef struct instruction_data
{
    Token_k token;
    word argv;
} Instruction_d;

typedef struct program_data
{
    Instruction_d* array;
    dword p, size;
} Program_d;
 
typedef struct memory_data
{
    word* array;
    dword p, size;
} Memory_d;

static void
die_usage(const char* program_name)
{ 
    fprintf(stderr, DIE_TEXT, program_name);
    exit(EXIT_SUCCESS);
}

static int
is_brainfuck(const char* filename)
{
    char* suffix = strrchr(filename, '.');
    if(suffix == NULL) return 1;
    return strncmp(suffix, FILE_EXTENSION, 2);
}

static inline int
ensure_size(Program_d* program, Memory_d* stack,
    Memory_d* memory, unsigned char debug)
{
    if(program != NULL && 
        (program->array = realloc(program->array, (program->size *= 2) *
        sizeof(Instruction_d))) == NULL)
        return EXIT_FAILURE;
    if(stack != NULL &&
        (stack->array = realloc(stack->array, (stack->size *= 2) *
        sizeof(word))) == NULL)
        return EXIT_FAILURE;
    if(memory != NULL)
    {
        if((memory->array = realloc(memory->array, (memory->size *= 2) *
            sizeof(word))) == NULL)
            return EXIT_FAILURE;
        for(dword i = memory->p; i < memory->size; i++) memory->array[i] = 0;
        if(debug) printf(DBG_TEXT, memory->size * sizeof(word) / 1024);
    }
    return EXIT_SUCCESS;
}

static inline int
interpret(Program_d* program, Memory_d* memory, unsigned char debug)
{
    int ignore = 0;

    switch(program->array[program->p].token)
    {
        case tok_in:    ignore = scanf("%u", &memory->array[memory->p]); break;
        case tok_out:   putchar((int)memory->array[memory->p]);          break;
        case tok_add:   memory->array[memory->p]++;                      break;
        case tok_sub:   memory->array[memory->p]--;                      break;
        case tok_right: memory->p++;                                     break;
        case tok_left:  memory->p--;                                     break;
        case tok_jz:    if(!memory->array[memory->p])
                            program->p = program->array[program->p].argv;
                                                                         break;
        case tok_jnz:   if(memory->array[memory->p])
                            program->p = program->array[program->p].argv;
                                                                         break;
        default:        return EXIT_FAILURE;
    }
    program->p++;

    if((memory->p == memory->size &&
        ensure_size(NULL, NULL, memory, debug)) || !(ignore <= 1)) 
        return EXIT_FAILURE;
    return EXIT_SUCCESS;
}


static int
parse(Program_d* program, Memory_d* stack, char c)
{
    switch(c)
    {
        case ',': APPEND(tok_in);    break;
        case '.': APPEND(tok_out);   break;
        case '+': APPEND(tok_add);   break;
        case '-': APPEND(tok_sub);   break;
        case '>': APPEND(tok_right); break;
        case '<': APPEND(tok_left);  break;
        case '[': APPEND(tok_jz);
                  PUSH(program->p);  break;
        case ']': APPEND(tok_jnz);
                  if(stack->p == 0)
                  {
                      stack->p++;
                      return EXIT_FAILURE;
                  }
                  dword jp = POP();
                  program->array[program->p].argv = jp;
                  program->array[jp].argv = program->p; break;
        default:  program->p--;
    }
    program->p++;

    if(program->p == program->size && ensure_size(program, NULL, NULL, 0))
        return EXIT_FAILURE;
    if(stack->p == stack->size && ensure_size(NULL, stack, NULL, 0))
        return EXIT_FAILURE;

    return EXIT_SUCCESS;
}

static int
run(Program_d* program, Memory_d* memory, unsigned char debug)
{   char stdout_buffer[1 << 9];
    //printf("%lu\n", sizeof(word));
    setvbuf(stdout, stdout_buffer, _IOLBF, sizeof(stdout_buffer));
    if(debug) printf(FDBG_TEXT, memory->size * sizeof(word) / 1024);

    while(!(program->array[program->p].token == tok_null ||
        program->p >= program->size || memory->p >= memory->size ||
        program->p >  MAX_WORD      || memory->p >  MAX_WORD))
        if(interpret(program, memory, debug) == EXIT_FAILURE) break;

    if(program->array[program->p].token != tok_null ||
        program->p >= program->size || memory->p >= memory-> size ||
        program->p >  MAX_WORD      || memory->p >  MAX_WORD)
    {
        if(program->array != NULL) free(program->array);
        if(memory->array  != NULL) free(memory->array);
        return EXIT_FAILURE;
    }

    free(program->array);
    free(memory->array);
    return EXIT_SUCCESS;
}

static int
cook(FILE* fp, Program_d* program, Memory_d* stack)
{
    char c;

    while(!((c = fgetc(fp)) == EOF ||
        program->p >= program->size || stack->p >= stack->size ||
        program->p >  MAX_WORD      || stack->p >  MAX_WORD))
        if(parse(program, stack, c) == EXIT_FAILURE) break;

    if(c != EOF ||
        program->p >= program->size || stack->p >= stack->size ||
        program->p >  MAX_WORD      || stack->p >  MAX_WORD || stack->p != 0)
    {
        if(program->array != NULL) free(program->array);
        if(stack->array   != NULL) free(stack->array);
        return EXIT_FAILURE;
    }

    program->array[program->p].token = tok_null;
    program->p = 0;
    return EXIT_SUCCESS;
}

static void
init(Program_d* program, Memory_d* stack, Memory_d* memory)
{
    program->p     = stack->p    = memory->p    = 0;
    program->size  = stack->size = memory->size = 256;

    program->array = malloc(program->size * sizeof(Instruction_d));
    stack->  array = malloc(stack->size   * sizeof(word));
    memory-> array = calloc(memory->size,   sizeof(word));

    if(program == NULL || stack == NULL || memory == NULL)
    { 
        if(program != NULL) free(program);
        if(stack   != NULL) free(stack);
        if(memory  != NULL) free(memory);
        exit(EXIT_FAILURE);
    }
}

int
main(int argc, char* argv[])
{
    int status = EXIT_FAILURE;
    Program_d program;
    Memory_d stack, memory;
    unsigned char debug = 0;
    FILE* fp = fopen(argv[1], "r");

    if(argc < 2 || fp == NULL) die_usage(argv[0]);
    if(is_brainfuck(argv[1]) != EXIT_SUCCESS)
    {
        fclose(fp);
        die_usage(argv[0]);
    }
    if(argc == 3 && strncmp(argv[2], "-d", 2) == 0) debug = 1;

    init(&program, &stack, &memory);
    status = cook(fp, &program, &stack);
    fclose(fp);
    if(!status) status = run(&program, &memory, debug);
    return status;
}
