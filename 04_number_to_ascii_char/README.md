# Number to ASCII Character Example

This assembly program demonstrates how to convert a numeric value to its ASCII character representation and print it to the console.

## Overview

The program performs the following operations:
1. Stores the number 7 in the RAX register
2. Converts it to an ASCII character by adding the ASCII offset
3. Prints the resulting character to the console

## Code Walkthrough

### Entry Point

```asm
global                  _start

_start:                 mov       rax,      7
                        call      _print_digit

                        mov       rax,      60
                        mov       rdi,      0
                        syscall
```

The program starts at `_start`, loads the value 7 into the RAX register, calls the `_print_digit` subroutine, and then exits with status code 0.

### ASCII Conversion and Printing

```asm
_print_digit:           add       rax,      48
                        mov       [digit],  al

                        mov       rax,      1
                        mov       rdi,      1
                        mov       rsi,      digit
                        mov       rdx,      2
                        syscall
                        ret
```

This subroutine:
1. Adds 48 to the value in RAX, converting it to its ASCII representation (ASCII '0' starts at decimal 48)
2. Stores only the lower byte (AL register) into the `digit` variable
3. Uses the "write" system call to print the character to the console

### Data Section

```asm
section                 .data
digit:                  db        0, 10
```

The data section contains a 2-byte area:
- First byte: For storing the converted ASCII digit (initially 0)
- Second byte: The newline character (ASCII 10)

## Building and Running

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

```
7
```

## Key Concepts

- Number to ASCII conversion (adding offset 48)
- Register operations
- Byte-level memory manipulation
- System calls for output
