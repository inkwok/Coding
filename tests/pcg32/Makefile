CC = gcc
TARGET = ./target/slots
FILES  = ./src/main.c
FLAGS  = -std=c99 -Wall -Wextra -Wpedantic -Werror -Og -ggdb -march=native -flto

$(TARGET): $(FILES)
	$(CC) $(FLAGS) -o $(TARGET) $(FILES)
