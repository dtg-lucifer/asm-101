# External Libraries Example

This assembly program demonstrates how to use external C library functions (from GCC) in x86-64 assembly code, implementing a simple loop based on user input.

## Overview

The program:
1. Asks the user to enter a number
2. Uses a do-while loop to print a message the specified number of times
3. Uses C standard library functions (printf, scanf) for input/output operations

## Code Walkthrough

### Global Declaration and External References

```asm
global    main
extern    printf, scanf
```

Unlike the basic examples that use the `_start` entry point, this program uses `main` as its entry point because it's linked with the C runtime. The `extern` directive tells the assembler that `printf` and `scanf` are external symbols that will be resolved during linking.

### Stack Frame Setup

```asm
push rbp
mov rbp, rsp
sub rsp, 16
```

This sets up a standard stack frame:
- Save the previous base pointer
- Set the new base pointer to the current stack position
- Reserve 16 bytes of stack space for local variables

### Calling printf

```asm
xor eax, eax
lea rdi, [msg]
call printf
```

- `xor eax, eax` clears RAX, indicating no vector registers are used
- `lea rdi, [msg]` loads the address of our format string into RDI (first parameter)
- `call printf` invokes the C library function

### Calling scanf

```asm
mov eax, 0
lea rdi, [format]
lea rsi, [number]
call scanf
```

- Sets up parameters for scanf:
  - RDI: format string ("%d")
  - RSI: address where the input will be stored
- Calls the C library function to read user input

### The Do-While Loop

```asm
mov DWORD [rbp - 4], 0  ; Initialize i = 0

loop:
    ; Print loop message
    xor eax, eax
    mov edx, [number]
    mov rsi, [rbp - 4]
    lea rdi, [msg2]
    call printf

    ; Increment i
    mov ecx, DWORD [number]
    add DWORD [rbp - 4], 1

    ; Compare and continue if i <= number
    cmp [rbp - 4], ecx
    jle loop
```

- Local variable `i` is stored at `[rbp - 4]`
- The loop prints the current iteration number and the target number
- After each iteration, `i` is incremented
- The loop continues as long as `i <= number`

### Function Cleanup and Return

```asm
add rsp, 16
leave
ret
```

- Releases the reserved stack space
- `leave` instruction restores the stack frame (equivalent to `mov rsp, rbp; pop rbp`)
- Returns control to the caller

### Data Sections

```asm
section   .data
    msg:      db "Enter a number: ", 0
    msg2:     db "Looping %d of %d", 10, 0
    format:   db "%d", 0

section   .bss
    number resb 4
```

- `.data` section contains null-terminated strings for messages and format specifiers
- `.bss` section reserves 4 bytes for the user's input number

## Building and Running

This example uses GCC as the linker instead of LD to properly link with the C standard library:

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

```
Enter a number: 3
Looping 0 of 3
Looping 1 of 3
Looping 2 of 3
Looping 3 of 3
```

## Key Concepts

- Integration with C library functions
- Stack frame management
- Local variables on the stack
- Control flow with loop constructs
- User input processing
