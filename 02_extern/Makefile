AS=nasm
ASFLAGS=-f elf64 -g
LD=gcc
LDFLAGS=-m64 -no-pie
SOURCES=$(wildcard *.asm)
OBJECTS=$(SOURCES:.asm=.o)
EXECUTABLE=main
BIN=bin

all: setup $(SOURCES) $(EXECUTABLE)
.PHONY: all

setup:
	mkdir -p $(BIN)
.PHONY: setup

$(EXECUTABLE): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o ./bin/$@

$(OBJECTS): $(SOURCES)
	$(AS) $(ASFLAGS) $(SOURCES)

clean:
	rm -rf $(OBJECTS) $(BIN)
.PHONY: clean
