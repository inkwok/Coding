#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/random.h>

#define NUM_SYMBOLS 6
#define LEN_SLOTS 25

typedef enum symbol_type {
    SYM_0,
    SYM_1,
    SYM_2,
    SYM_3,
    SYM_4,
    SYM_5,
} symbol_t;

const uint8_t weights[] = { 40, 65, 80, 90, 97 };
const char* emojis[] = { "🍉", "🍒", "🍋", "🔔", "💰", "💎" };

int get_weights(uint8_t* probability_table) {
    uint64_t entropy;
    int i = 0;
    int window = 0;

    if(getrandom(&entropy, sizeof(entropy), 0) != sizeof(entropy)) return 1;
    while(i < LEN_SLOTS) {
        uint8_t byte;

        if(window < 64) byte = (entropy >> window) & 0x7f;
        window += 7;
        if(window >= 64) {
            if(getrandom(&entropy, sizeof(entropy), 0) != sizeof(entropy))
                return 1;
            window = 0;
        }
        if(byte <= 99) probability_table[i++] = byte;
    }
    return 0;
}

symbol_t get_symbol(uint8_t val) {
    if(val <= weights[0]) return SYM_0;
    if(val <= weights[1]) return SYM_1;
    if(val <= weights[2]) return SYM_2;
    if(val <= weights[3]) return SYM_3;
    if(val <= weights[4]) return SYM_4;
    return SYM_5;
}

void get_slot_id(uint8_t* weights, uint8_t* slots) {
    for(int i = 0; i < LEN_SLOTS; i++) slots[i] = get_symbol(weights[i]);
}

void print_symbols(uint8_t* slot_id) {
    for(int i = 0; i < LEN_SLOTS; i += 5) {
        printf("%s %s %s %s %s\n",
            emojis[slot_id[i + 0]], emojis[slot_id[i + 1]],
            emojis[slot_id[i + 2]], emojis[slot_id[i + 3]],
            emojis[slot_id[i + 4]]);
    }
}

int init_money(unsigned int* money) {
    FILE* fp = fopen("money.txt", "r");

    if(fp == NULL) return -1;
    if(fscanf(fp, "%u", money) != 1) return -1;
    fclose(fp);
    return 0;
}

typedef struct {
    uint8_t contains_5;
    uint8_t contains_4;
    uint8_t contains_3;
    uint8_t location[5];
} rc_data;

typedef struct {
    rc_data row[5];
    rc_data col[5];
} table_data;

int check_r5(uint8_t* s, int r) {
    int x = r * 5;

    return s[x + 0] == s[x + 1] &&
           s[x + 1] == s[x + 2] &&
           s[x + 2] == s[x + 3] &&
           s[x + 3] == s[x + 4];
}

int check_r4(uint8_t* s, int r, table_data* t) {
    int x = r * 5;

    if(t->row[r].contains_5) return 0;

    return (s[x + 0] == s[x + 1] &&
            s[x + 1] == s[x + 2] &&
            s[x + 2] == s[x + 3]) ||
           (s[x + 1] == s[x + 2] &&
            s[x + 2] == s[x + 3] &&
            s[x + 3] == s[x + 4]);
}

// 0  1  2  3  4 
// 5  6  7  8  9
// 10 11 12 13 14
// 15 16 17 18 19
// 20 21 22 23 24

int check_c5(uint8_t* s, int r) {
    return s[r +  0] == s[r +  5] &&
           s[r +  5] == s[r + 10] &&
           s[r + 10] == s[r + 15] &&
           s[r + 15] == s[r + 20];
}

int check_c4(uint8_t* s, int r, table_data* t) {
    if(t->col[r].contains_5) return 0;

    return (s[r +  0] == s[r +  5] &&
            s[r +  5] == s[r + 10] &&
            s[r + 10] == s[r + 15]) ||
           (s[r +  5] == s[r + 10] &&
            s[r + 10] == s[r + 15] &&
            s[r + 15] == s[r + 20]);
}



table_data init_table(void) {
    table_data t;

    for(int i = 0; i < 5; i++) {
        t.row[i].contains_5 = 0;
        t.row[i].contains_4 = 0;
        t.row[i].contains_3 = 0;
    }

    for(int i = 0; i < 5; i++) {
        t.col[i].contains_5 = 0;
        t.col[i].contains_4 = 0;
        t.col[i].contains_3 = 0;
    }
    return t;
}

void validate_rows(uint8_t* slot_id, table_data* t) {
    //start with rows of 5
    for(int i = 0; i < 5; i++) {
        if(check_r5(slot_id, i)) t->row[i].contains_5 = 1;
        if(check_r4(slot_id, i, t)) t->row[i].contains_4 = 1;
    }
}

void validate_cols(uint8_t* slot_id, table_data* t) {
    for(int i = 0; i < 5; i++) {
        if(check_c5(slot_id, i)) t->col[i].contains_5 = 1;
        if(check_c4(slot_id, i, t)) t->col[i].contains_4 = 1;
        
    }
}
//NEEDS A COLLISION PRUNER
void validate_paylines(uint8_t* slot_id) {
    table_data t = init_table();
    validate_rows(slot_id, &t);
    validate_cols(slot_id, &t);
    printf("fives:\n");
    for(int i = 0; i < 5; i++) {
        printf("row %d: %d\tcol %d: %d\n", i, t.row[i].contains_5, i, t.col[i].contains_5);
    }
    printf("fours:\n");
    for(int i = 0; i < 5; i++) {
        printf("row %d: %d\tcol %d: %d\n", i, t.row[i].contains_4, i, t.col[i].contains_4);
    }

    // for(int i = 0; i < 5; i++) {
        // if(t.row[i].contains_5) printf("row %d contains 5 in a row.", i);
        // if(t.col[i].contains_5) printf("col %d contains 5 in a row.", i);
    // }
}

int game_loop(void) {
    uint8_t weights[LEN_SLOTS];
    uint8_t slot_id[LEN_SLOTS];
    int playing = 1;
    unsigned int money = 0;
    char bet_input[64] = {0};
    unsigned int bet_amount = 0;

    init_money(&money);
    while(playing) {
        printf("Balance: %u\nBet: ", money);
        if(fgets(bet_input, sizeof(bet_input), stdin) == NULL) return -1;
        printf("\n");
        bet_amount = strtoul(bet_input, NULL, 10);

        if(get_weights(weights)) return 1;
        get_slot_id(weights, slot_id);
        print_symbols(slot_id);
        validate_paylines(slot_id);
        //save money amount on exit
        break;
     }
    return 0;

}

int main(void) {
    return game_loop();
}
