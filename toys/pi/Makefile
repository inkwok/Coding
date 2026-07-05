CC     = gcc
TARGET = ./target/pi
FILES  = ./src/main.c
FLAGS  = -std=c99 -Wall -Wextra -Werror -Wpedantic -Og -ggdb -march=native -flto

$(TARGET): $(FILES)
	$(CC) $(FLAGS) -o $(TARGET) $(FILES) -lm
