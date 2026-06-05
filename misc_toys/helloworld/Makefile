TARGET = hello
FILES  = main.c
FLAGS  = -Wall -Wextra -Werror -Wpedantic -std=c99 -ggdb
SFLAGS = -S -masm=intel
all: $(TARGET) main.s

$(TARGET): $(FILES)
	$(CC) $(FLAGS) -o $(TARGET) $(FILES)

main.s: $(FILES)
	$(CC) $(SFLAGS) -o main.s $(FILES)
