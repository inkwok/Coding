EXE_TARGET = ./target/bf
ASM_TARGET = ./target/main.s
FILES  = ./src/main.c
EFLAGS  = -Wall -Wextra -Wpedantic -std=c99 -ggdb -Ofast -Werror
SFLAGS = -S -masm=intel
all: $(EXE_TARGET) #$(ASM_TARGET)

$(EXE_TARGET): $(FILES)
	$(CC) $(EFLAGS) -o $(EXE_TARGET) $(FILES)

#$(ASM_TARGET): $(FILES)
#	$(CC) $(SFLAGS) -o $(ASM_TARGET) $(FILES)
