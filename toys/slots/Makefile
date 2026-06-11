$(CC)  = gcc
TARGET = ./target/slots
FILES  = src/main.c src/gen.c src/gen.h
FLAGS  = -O0 -Wall -Wextra -Wpedantic -std=c99 -ggdb# -Werror

$(TARGET): $(FILES)
	$(CC) $(FLAGS) -o $(TARGET) $(FILES)
