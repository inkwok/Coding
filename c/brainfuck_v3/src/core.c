#include "core.h"
#include "extras.h"
#include <stdlib.h>

static const char* const     DBG_TEXT = "\n\x1b[1;32mMemory size: %lu Kib\x1b[0m\n";
static const char* const     FDBG_TEXT = "\x1b[1;32mMemory size: %lu Kib\x1b[0m\n";
static char                  stdout_buffer[1 << 9] = {0};
static volatile sig_atomic_t stop = 0;

static inline void
handle_sigterm(int sig)
{
    (void)sig;
    stop = 1;
}

static mem_t
init_stack(void)
{
    mem_t s =
    {
        .tape = malloc(256 * sizeof(WORD)),
        .size = 256,
        .p = 0,
    };

    return s;
}

static prog_t
init_program(void)
{
    prog_t p =
    {
        .tape = malloc(256 * sizeof(inst_t)),
        .size = 256,
        .cflags = 0,
        .rflags = 0,
    };

    return p;
}

static mem_t
init_memory(void)
{
    mem_t m =
    {
        .tape = calloc(256, sizeof(WORD)),
        .size = 256,
        .p = 0,
    };

    return m;
}

static inline int
ensure_size(prog_t* p, mem_t* s, mem_t* m, const uint8_t f)
{
    if(p && p->tape && !(p->tape = realloc(p->tape, (p->size *= 2) *
        sizeof(inst_t))))
    {
        return EXIT_FAILURE;
    }

    if(s && s->tape && !(s->tape = realloc(s->tape, (s->size *= 2) *
        sizeof(WORD))))
    {
        return EXIT_FAILURE;
    }

    if(m && m->tape)
    {
        if(!(m->tape = realloc(m->tape, (m->size *= 2) * sizeof(WORD))))
        {
            return EXIT_FAILURE;
        }

        memset(m->tape + m->p, 0, (m->size - m->p) * sizeof(WORD));

        if(f & DEBUG)
        {
            printf(DBG_TEXT, m->size * sizeof(WORD) / 1024);
        }
    }

    return EXIT_SUCCESS;
}

static inline int
interpret(const prog_t program, DWORD* p, mem_t* memory, const uint8_t f)
{
    int _x = 0;
    switch(program.tape[*p].token)
    {

        case TOK_IN:    _x = scanf("%u", &memory->tape[memory->p]); break;
        case TOK_OUT:   putchar((int)memory->tape[memory->p]);      break;
        case TOK_ADD:   memory->tape[memory->p]++;                  break;
        case TOK_SUB:   memory->tape[memory->p]--;                  break;
        case TOK_RIGHT: memory->p++;                                break;
        case TOK_LEFT:  memory->p--;                                break;
        case TOK_JZ:    if(!memory->tape[memory->p])
                        {
                            *p = program.tape[*p].argument;
                        }                                           break;
        case TOK_JNZ:   if(memory->tape[memory->p])
                        {
                            *p = program.tape[*p].argument;
                        }                                           break;
        default:        return EXIT_FAILURE;
    }
    (*p)++;

    if(_x == EOF || (memory->p == memory->size &&
        ensure_size(NULL, NULL, memory, f)))
    {
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

int
run(const prog_t program, const uint8_t flags)
{
    mem_t memory = init_memory();
    DWORD p = 0;
    struct sigaction sa =
    {
        .sa_handler = handle_sigterm
    };

    sigemptyset(&sa.sa_mask);
    sigaction(SIGTERM, &sa, NULL);

    setvbuf(stdout, stdout_buffer, _IOLBF, sizeof(stdout_buffer));

    if(!memory.tape)
    {
        return EXIT_FAILURE;
    }

    if(flags & DEBUG)
    {
        printf(FDBG_TEXT, memory.size * sizeof(WORD) / 1024);
    }

    while(!(program.tape[p].token == TOK_NULL || IBOUND) && !stop)
    {
        if(interpret(program, &p, &memory, flags) == EXIT_FAILURE)
        {
            break;
        }
    }

    if(program.tape[p].token != TOK_NULL || IBOUND)
    {
        if(memory.tape)
        {
            free(memory.tape); //do error handling here
        }
        return EXIT_FAILURE;
    }

    if(memory.tape)
    {
        free(memory.tape);
    }

    if(stop == 1)
    {
        fflush(stdout);
    }

    return EXIT_SUCCESS;
}

static inline void
append(prog_t* self, DWORD* p, const token_t t)
{
    self->tape[*p].token = t;
}

static inline void
push(mem_t* self, DWORD* p)
{
    self->tape[self->p++] = *p;
}

static inline DWORD
pop(mem_t* self)
{
    return self->tape[--self->p];
}

static inline int
parse(prog_t* program, mem_t* stack, DWORD* p, const char c, uint8_t f)
{
    switch(c)
    {
        case ',': append(program, p, TOK_IN);      break;
        case '.': append(program, p, TOK_OUT);     break;
        case '+': append(program, p, TOK_ADD);     break;
        case '-': append(program, p, TOK_SUB);     break;
        case '<': append(program, p, TOK_LEFT);    break;
        case '>': append(program, p, TOK_RIGHT);   break;
        case '[': append(program, p, TOK_JZ);
                  push(stack, p);                  break;
        case ']': append(program, p, TOK_JNZ);
                  if(stack->p == 0)
                  {
                      stack->p++;
                      return EXIT_FAILURE;
                  }
                  DWORD jp = pop(stack);
                  program->tape[*p].argument = jp;
                  program->tape[jp].argument = *p; break;
        default: (*p)--;
    }

    (*p)++;

    if(*p == program->size && ensure_size(program, NULL, NULL, f))
    {
        return EXIT_FAILURE;
    }
    if(stack->p == stack->size && ensure_size(NULL, stack, NULL, f))
    {
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

prog_t
cook(const char* filename, const uint8_t flags)
{
    char c = 0;
    DWORD p = 0;
    prog_t program = init_program();
    mem_t stack = init_stack();
    FILE* fp = open_and_check(filename);

    if(!program.tape || !stack.tape) // may err here
    {
        if(program.tape)
        {
            free(program.tape);
        }
        if(stack.tape)
        {
            free(stack.tape);
        }
    }

    while(!(c == EOF || PBOUND) && program.tape)
    {
        c = fgetc(fp);
        if(parse(&program, &stack, &p, c, flags) == EXIT_FAILURE)
        {
            program.cflags |= C_ERRPRS;
            break;
        }
    }

    if(c != EOF || stack.p != 0 || PBOUND)
    {
        if(program.tape)
        {
            free(program.tape);
        }
        if(stack.tape)
        {
            free(stack.tape);
        }

        program.size = 0;
        program.cflags |= C_ERRBND;
    }

    if(program.tape)
    {
        program.tape[p].token = TOK_NULL;
    }

    fclose(fp);

    return program;
}
