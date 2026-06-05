EXE_TARGET = ./target/kilo
ASM_TARGET = ./target/main.s
FILES  = ./src/main.c
EFLAGS  = -Wall -Wextra -Werror -Wpedantic -std=c99 -ggdb
SFLAGS = -S -masm=intel
all: $(EXE_TARGET) $(ASM_TARGET)

$(EXE_TARGET): $(FILES)
	$(CC) $(EFLAGS) -o $(EXE_TARGET) $(FILES)

$(ASM_TARGET): $(FILES)
	$(CC) $(SFLAGS) -o $(ASM_TARGET) $(FILES)
