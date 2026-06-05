#include <stdio.h>
#include <stdint.h>

#define word      uint8_t
#define SIZE_WORD 256
#define MAX_WORD  0xFF
#define SP_INIT   0xF0
#define ZERO      0x80
#define SIGN      0x40
#define CARRY     0x20
#define HALT      0x01

enum {
    nop, lia, lib, jmp, lda, ldb, mxa, mxb,
    sta, stx, in,  cal, jz,  js,  jv,  jsz,
    hlt, and, or,  xor, sar, slr, sal, sll,
    add, sub, out, ret, jnz, jns, jnv, jnsz
};

struct registers {
    word IR; word A;
    word SP; word B;
    word PC; word X;
    word MC; word GIN;
    word MP; word OUT;
    word F;
};

word memory[SIZE_WORD] = {0};

void init(struct registers* reg) {
    reg->IR = reg->PC = reg->MP = reg-> MC = reg->F = reg->A = reg->B = reg->X = 0;
    reg->SP = SP_INIT;
    reg->F |= ZERO;
}

int main(void) {
    struct registers reg;
    init(&reg);
    return 0;
}
