# Hello World Example

This is a basic "Hello, World" assembly program that demonstrates fundamental concepts of x86-64 assembly programming on Linux.

## Overview

This program performs the following operations:
1. Prints "Hello, World" to the console
2. Initializes a variable with the value 4005
3. Exits with status code 0

## Code Walkthrough

### Global Entry Point

```asm
global    _start
```
This declares the `_start` symbol as global, making it the entry point of our program.

### Text Section

```asm
section   .text
_start:     call _print
```
The `.text` section contains executable code. The program begins at `_start` by calling our custom print function.

### Setting a Variable

```asm
mov eax, 4005
mov [data], eax
```
These lines store the value 4005 in the `data` variable that we've reserved in the BSS section.

### Exit Syscall

```asm
mov       rax, 60
mov       rdi, 0
syscall
```
This prepares and executes the "exit" system call (syscall 60), with exit code 0.

### Print Function

```asm
_print:     mov       rax, 1
            mov       rdi, 1
            mov       rsi, message_str
            mov       rdx, message_len
            syscall
            ret
```
This function writes our message to standard output using the "write" system call (syscall 1).
- `rax=1` specifies the write system call
- `rdi=1` is the file descriptor (stdout)
- `rsi` points to the message string
- `rdx` contains the length of the string in bytes

### Data Section

```asm
section   .data
message_str: db       "Hello, World", 10
message_len: equ      $-message_str
```
This section defines our string constant with a newline character (ASCII 10).
The `message_len` is calculated as the difference between the current position (`$`) and the beginning of `message_str`.

### BSS Section

```asm
section .bss
data:   resb 4
```
The BSS section reserves uninitialized memory. Here we reserve 4 bytes for our `data` variable.

## Building and Running

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

```
Hello, World
```
