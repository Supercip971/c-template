
MKCWD=mkdir -p $(@D)

PROJECT_NAME = test

CC = gcc
CFLAGS = -O2 --analyzer -Isrc/ -fsanitize=address -fsanitize=undefined

BUILD_DIR = build

# source files

CFILES = $(wildcard src/*.c)
HFILES = $(wildcard src/*.h)
OFILES = $(patsubst src/%.c, $(BUILD_DIR)/%.o, $(CFILES))

OUTPUT = build/$(PROJECT_NAME).elf


$(OUTPUT): $(OFILES)
	@$(MKCWD)
	@echo "[ $@ ] $^"
	@$(CC) -o $@ $^ $(CFLAGS)

$(BUILD_DIR)/%.o: src/%.c 
	@$(MKCWD)
	@echo "[ $@ ] $^"
	@$(CC) $^ -c -o $@  $(CFLAGS)

run: $(OUTPUT)
	$(OUTPUT)

all: $(OUTPUT)

clean:
	rm -rf build/