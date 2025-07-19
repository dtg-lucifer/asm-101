# User Input Example

This assembly program demonstrates how to read user input from the standard input, store it in memory, and then print it back out.

## Overview

The program performs the following operations:
1. Asks the user for their name
2. Reads the name from standard input
3. Greets the user by name

## Code Walkthrough

### Program Structure

This program is structured as a series of subroutines, each responsible for a specific task. The `_start` function calls these subroutines in sequence to perform the overall program logic.

### Entry Point

```asm
global                  _start

_start:                 call      _print_text
                        call      _get_name
                        call      _print_greetings
                        call      _print_name

                        mov       rax, 60
                        mov       rdi, 0
                        syscall
```

The program begins at `_start`, which calls four subroutines in sequence and then exits with status code 0.

### Printing the Prompt

```asm
_print_text:            mov       rax, 1
                        mov       rdi, 1
                        mov       rsi, text
                        mov       rdx, text_len
                        syscall
                        ret
```

This subroutine uses the "write" system call (syscall 1) to display the prompt asking for the user's name.

### Reading User Input

```asm
_get_name:              mov       rax, 0
                        mov       rdi, 0
                        mov       rsi, name
                        mov       rdx, 16
                        syscall
                        mov       rbx, rax
                        ret
```

This subroutine uses the "read" system call (syscall 0) to read up to 16 bytes from standard input into the `name` buffer. The actual number of bytes read is returned in RAX and saved in RBX.

### Printing the Greeting

```asm
_print_greetings:       mov       rax, 1
                        mov       rdi, 1
                        mov       rsi, greetings
                        mov       rdx, greetings_len
                        syscall
                        ret
```

This subroutine prints the "Hello, " greeting text.

### Printing the User's Name

```asm
_print_name:            mov       rax, 1
                        mov       rdi, 1
                        mov       rsi, name
                        mov       rdx, 16
                        syscall
                        ret
```

This subroutine prints the name that was previously read from the user.

### Data Section

```asm
section                 .data
text:                   db    "Hey, what is your name? "
text_len:               equ   $-text
greetings:              db    "Hello, "
greetings_len:          equ   $-greetings
```

The data section contains the prompt and greeting strings, along with their calculated lengths.

### BSS Section

```asm
section                 .bss
name:                   resb  16
```

The BSS section reserves 16 bytes of uninitialized memory to store the user's name.

## Building and Running

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

```
Hey, what is your name? John
Hello, John
```

## Key Concepts

- System calls for input/output operations
- Subroutine implementation and calling
- Memory allocation for user input
- String handling in assembly
