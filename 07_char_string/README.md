# Character and String Example

This assembly program demonstrates how to work with characters, arrays (lists), and perform basic operations like printing and traversing data in x86-64 assembly.

## Overview

The program performs the following operations:
1. Prints a single character ('A') with a newline
2. Traverses a null-terminated list of integers (1-5)
3. Converts each integer to its ASCII representation
4. Prints the integers with spaces in between

## Code Walkthrough

### Data Definitions

```asm
section         .data
char:           db  'A', 0, 10
char_len:       equ $-char

bad_list:       db  1, 2, 3, 4, 5
good_list:      db  1, 2, 3, 4, 5, -1

newline:        db  10
space:          db  32
digit_buf:      db  0
```

This section defines:
- `char`: A buffer containing the letter 'A', a null byte, and a newline character
- `bad_list`: A list of integers without a proper terminator
- `good_list`: A list of integers with a -1 (0xFF) terminator
- Support characters and buffers for formatting output

The `equ $-char` calculates the length of the `char` buffer by subtracting the current position (`$`) from the start of `char`.

### Main Program Flow

```asm
_start:
                ; Print the char buffer "A\n"
                mov     rax, 1
                mov     rdi, 1
                mov     rsi, char
                mov     rdx, char_len
                syscall

                ; rbx points to good_list
                mov     rbx, good_list

                call    .print_loop
                call    .print_newline
                call    .done
```

The program begins by:
1. Printing the character 'A' followed by a newline
2. Setting up `rbx` to point to the beginning of `good_list`
3. Calling subroutines to process and display the list

### List Processing Loop

```asm
.print_loop:
                ; Load byte from list
                movzx   rax, byte [rbx]
                cmp     al, 0xFF
                je      .ret_loop

                ; Convert number to ASCII
                add     al, '0'
                mov     [digit_buf], al

                ; Print the digit
                mov     rax, 1
                mov     rdi, 1
                mov     rsi, digit_buf
                mov     rdx, 1
                syscall

                ; Print space
                mov     rax, 1
                mov     rdi, 1
                mov     rsi, space
                mov     rdx, 1
                syscall

                inc     rbx
                jmp     .print_loop
```

This subroutine:
1. Loads a byte from the current position in the list
2. Checks if it's the terminator value (0xFF, or -1)
3. Converts the number to its ASCII representation by adding the ASCII value of '0'
4. Prints the resulting character
5. Prints a space
6. Advances to the next position in the list
7. Repeats until it reaches the terminator

### Utility Subroutines

```asm
.ret_loop:
                ret

.print_newline:
                mov     rax, 1
                mov     rdi, 1
                mov     rsi, newline
                mov     rdx, 1
                syscall
                ret

.done:
                mov     rax, 60
                xor     rdi, rdi
                syscall
                ret
```

These helper subroutines:
1. `.ret_loop`: Returns from the list processing routine
2. `.print_newline`: Prints a newline character
3. `.done`: Terminates the program with exit code 0

## Building and Running

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

```
A
1 2 3 4 5
```

## Key Concepts

- Working with character data and ASCII values
- List/array traversal in assembly
- Using terminators to mark the end of data structures
- Number-to-ASCII conversion
- Local subroutines with dot prefix notation
- Zero-extension with `movzx` for clean register operations
