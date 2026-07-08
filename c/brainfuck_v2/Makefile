CC       ?= gcc

TARGET   := target/bf
SRC      := $(wildcard src/*.c)
OBJ      := $(patsubst src/%.c,obj/%.o,$(SRC))

PPFLAGS  += -MMD -MP
CFLAGS   += -std=c99 -Wall -Wextra -Wpedantic -Og -ggdb

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $^

obj/%.o: src/%.c
	mkdir -p $(dir $@)
	$(CC) $(PPFLAGS) $(CFLAGS) -c $< -o $@

clean:
	rm -rf target obj

-include $(OBJ:.o=.d)
