;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A simple program to demonstrate how the stack and memory addresses
;           work properly and how to access data
;---------------------------------------------------------------------------

section     .data
num:        dd 5          ; 4 bytes (32-bit integer)
num2:       db 2          ; 1 byte
num3:       db 1          ; 1 byte

section     .text
global      _start

_start:
    ; print the value stored in the num variable
    ; mov     rax, 1
    ; mov     rbx, num          ; X wrong
    ; syscall
    ; this won't do anything meaningful because rbx is storing
    ; the address of the num variable, not the value

    ; mov     rax, 1
    ; mov     ebx, [num]        ; ✓ correct: extracting the 4-byte value
    ; syscall
    ;
    ; this will still not print because sys_write needs a buffer,
    ; not just a number in a register

    ; Proper way to move data from smaller memory into wider registers
    ; movzx     rbx, byte [num2]     ; zero-extend 1 byte to 64-bit rbx
    ; movzx     rcx, byte [num3]     ; zero-extend 1 byte to 64-bit rcx

    ; only setting the lower byte to store short value in big register
    mov       bl, [num2]
    mov       cl, [num3]

    ; Exit the program cleanly
    mov       rax, 60              ; syscall number for sys_exit
    xor       rdi, rdi             ; exit code 0
    syscall
