# Stack Memory Example

This assembly program demonstrates fundamental concepts of memory access, register operations, and how to properly handle different data sizes in x86-64 assembly.

## Overview

The program illustrates:
1. Declaration of variables with different sizes (1-byte vs 4-byte)
2. Common mistakes when accessing memory (commented out as examples)
3. Proper techniques for loading values from memory into registers
4. Handling different register sizes (8-bit, 32-bit, 64-bit)

## Code Walkthrough

### Data Section Declaration

```asm
section     .data
num:        dd 5          ; 4 bytes (32-bit integer)
num2:       db 2          ; 1 byte
num3:       db 1          ; 1 byte
```

The program defines three variables:
- `num`: A double-word (4 bytes) containing the value 5
- `num2`: A byte containing the value 2
- `num3`: A byte containing the value 1

### Memory Access Examples

The program includes commented-out examples showing incorrect ways to access memory:

```asm
; WRONG approach - using the address directly
; mov     rax, 1
; mov     rbx, num          ; X wrong
; syscall
```

This approach puts the memory address of `num` into `rbx`, not the value stored at that address.

```asm
; CORRECT but still not printable directly
; mov     rax, 1
; mov     ebx, [num]        ; ✓ correct: extracting the 4-byte value
; syscall
```

This correctly loads the value of `num` into `ebx`, but still wouldn't work for printing because system calls for output need pointers to buffers, not just values in registers.

### Proper Memory Access

```asm
; only setting the lower byte to store short value in big register
mov       bl, [num2]
mov       cl, [num3]
```

This demonstrates the proper way to load small values into larger registers by:
1. Using square brackets `[]` to access the value at the memory address
2. Using the appropriate register size (`bl` is the lowest 8-bit portion of `rbx`)

The program also includes a commented example of zero-extension:

```asm
; movzx     rbx, byte [num2]     ; zero-extend 1 byte to 64-bit rbx
; movzx     rcx, byte [num3]     ; zero-extend 1 byte to 64-bit rcx
```

This would load the byte values into the 64-bit registers while ensuring all higher bits are set to zero.

### Program Exit

```asm
mov       rax, 60              ; syscall number for sys_exit
xor       rdi, rdi             ; exit code 0
syscall
```

The program exits with status code 0 using the standard Linux syscall convention.

## Building and Running

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

This program doesn't produce visible output as it's designed to demonstrate memory access techniques. You can use a debugger like GDB to observe register values and memory operations.

## Key Concepts

- Data type sizes in assembly (byte, double-word)
- Memory addressing with square brackets `[]`
- Register parts (e.g., `bl` for lower 8 bits of `rbx`)
- Direct vs. indirect memory access
- Zero-extension of smaller values into larger registers
