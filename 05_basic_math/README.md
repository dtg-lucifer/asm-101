# Basic Math Operations Example

This assembly program demonstrates how to perform basic mathematical operations in x86-64 assembly language and convert the results to ASCII for display.

## Overview

The program showcases four basic arithmetic operations:
1. Division (7 ÷ 2)
2. Multiplication (7 × 3)
3. Addition (7 + 3)
4. Subtraction (7 - 3)

Each operation's result is converted to an ASCII string and displayed with appropriate labels.

## Code Walkthrough

### Entry Point and Division

```asm
_start:
    ; Division: 7 / 2
    xor     rdx, rdx                  ; clear out rdx to store the remainder
    mov     rax, 7
    mov     rbx, 2
    div     rbx                       ; quotient in rax, remainder in rdx

    push    rdx                       ; save remainder first
    push    rax                       ; save quotient on top
```

The program starts with division. The DIV instruction divides RAX by RBX:
- Quotient goes into RAX
- Remainder goes into RDX
- Before division, we clear RDX with XOR to ensure no remainder from previous operations
- Results are saved on the stack for later printing

### Printing Division Results

```asm
    call    _quo

    pop     rax                       ; pop quotient
    call    _print_rax                ; print quotient

    call    _rem
    pop     rax                       ; pop remainder
    call    _print_rax
    call    _newline
```

After division, the program:
1. Prints the "Quotient: " label
2. Pops and prints the quotient
3. Prints the ", Remainder: " label
4. Pops and prints the remainder

### Multiplication

```asm
    ; Multiplication: 7 * 3
    mov       rax, 7
    mov       rbx, 3
    mul       rbx                     ; rax = rax * rbx

    push      rax                     ; save the state of rax onto the stack
```

The MUL instruction multiplies RAX by RBX, storing the result in RAX. For larger results, the high bits would go into RDX, but that's not needed for this simple example.

### Addition

```asm
    ; Addition: 7 + 3
    mov       rax, 7
    mov       rbx, 3
    add       rax, rbx
```

Addition uses the ADD instruction, which adds the second operand (RBX) to the first (RAX) and stores the result in the first.

### Subtraction

```asm
    ; Subtraction: 7 - 3
    mov       rax, 7
    mov       rbx, 3
    sub       rax, rbx
```

Subtraction uses the SUB instruction, which subtracts the second operand (RBX) from the first (RAX) and stores the result in the first.

### Number to ASCII Conversion

```asm
_print_rax:
    mov     rcx, buffer + 19     ; point to end of buffer
    mov     rbx, 10              ; divisor for decimal

    cmp     rax, 0
    jne     .convert
    mov     byte [rcx], '0'
    jmp     .done

.convert:
    xor     rdx, rdx
.loop:
    div     rbx                  ; divide rax by 10
    add     dl, '0'              ; remainder to ASCII
    dec     rcx
    mov     [rcx], dl
    xor     rdx, rdx
    test    rax, rax
    jnz     .loop

.done:
    mov     rax, 1               ; syscall write
    mov     rdi, 1               ; stdout
    mov     rsi, rcx             ; pointer to string
    mov     rdx, buffer + 20
    sub     rdx, rcx             ; length
    syscall
    ret
```

This is the core conversion routine that transforms numeric values into printable ASCII. It:
1. Uses a division-based algorithm to extract each digit
2. Converts each digit to ASCII by adding '0' (48)
3. Builds the string from right to left
4. Handles the special case of zero

### Data and BSS Sections

```asm
section     .bss
buffer:     resb      20                    ; buffer to hold ASCII digits

section     .data
quo:        db        "Quotient: "
quo_len:    equ       $-quo
rem:        db        ", Remainder: "
rem_len:    equ       $-rem
ans:        db        "Answer: "
ans_len:    equ       $-ans
newline:    db        10    ; ASCII newline
```

- The BSS section reserves a 20-byte buffer for the ASCII representation of numbers
- The Data section contains labels and formatting strings

## Building and Running

```bash
# Compile the program
make

# Run the program
./bin/main
```

## Expected Output

```
Quotient: 3, Remainder: 1
Answer: 21
Answer: 10
Answer: 4
```

## Key Concepts

- Basic arithmetic operations (add, sub, mul, div)
- Stack usage for temporary storage
- Integer to ASCII conversion algorithm
- Subroutine organization
- System calls for output
