;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A simple assembly program to print the number stored
;           into the RAX register as ASCII character to the STDOUT
;---------------------------------------------------------------------------

section                 .data                                 ; setion for storing variables
digit:                  db        0, 10                       ; store 2 bytes


section                 .text                                 ; section for storing the actual code
global                  _start                                ; entry point to the label


_start:                 mov       rax,      7                 ; the number to print
                        call      _print_digit

                        mov       rax,      60
                        mov       rdi,      0
                        syscall


_print_digit:           add       rax,      48                ; offset with 48 to get the ASCII value
                        mov       [digit],  al                ; take only 2 bytes (rest is unnecessary)

                        ; print the digit
                        mov       rax,      1
                        mov       rdi,      1
                        mov       rsi,      digit
                        mov       rdx,      2
                        syscall
                        ret
