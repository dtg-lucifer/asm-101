;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A simple assembly program to print "Hello, World"
;           to the stdout 
;---------------------------------------------------------------------------

    global    _start                        ; entry point to the label


    section   .text                         ; section for storing the actual code
_start:     mov       rax, 1
            mov       rdi, 1
            mov       rsi, message_str      ; address of the string to the output
            mov       rdx, message_len      ; number of bytes
            syscall                         ; execute the operation

            mov eax, 4005                   ; move 4005 into eax (lower position or rax)
            mov [data], eax                 ; initialize a variable with 4005

            mov       rax, 60               ; system call for exit
            mov       rdi, 0                ; exit code 0
            syscall


    section   .data                         ; setion for storing variables
message_str: db       "Hello, World", 10    ; message with newline code
message_len: equ      $-message_str         ; length of the message string


    section .bss                            ; section for uninitialized data
data:   resb 4                              ; reserve 4 bytes for the data
