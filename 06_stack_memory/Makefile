AS=nasm
ASFLAGS=-f elf64 -g
LD=ld
LDFLAGS=-m elf_x86_64
SOURCES=$(wildcard *.asm)
OBJECTS=$(SOURCES:.asm=.o)
EXECUTABLE=main
BIN=bin

all: setup $(SOURCES) $(EXECUTABLE)
.PHONY: all

setup:
	mkdir -p bin
.PHONY: setup

$(EXECUTABLE): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o ./bin/$@

$(OBJECTS): $(SOURCES)
	$(AS) $(ASFLAGS) $(SOURCES)

clean:
	rm -rf *.o bin
.PHONY: clean
