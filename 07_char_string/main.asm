;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A simple assembly code to show how to interact with list and chars
;---------------------------------------------------------------------------

section         .data
char:           db  'A', 0, 10
char_len:       equ $-char

bad_list:       db  1, 2, 3, 4, 5
good_list:      db  1, 2, 3, 4, 5, -1

newline:        db  10
space:          db  32
digit_buf:      db  0

section         .text
global          _start

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
