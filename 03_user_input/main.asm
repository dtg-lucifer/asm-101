;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A simple assembly program to take user's name as input
;           then greet the user with the name
;---------------------------------------------------------------------------

section                 .data                                 ; setion for storing variables
text:                   db    "Hey, what is your name? "       ; reserve the text to be printed
text_len:               equ   $-text                          ; get the length
greetings:              db    "Hello, ",                      ; reserve the greeting text
greetings_len:          equ   $-greetings                     ; also with the length


section                 .bss                                  ; section for uninitialized data
name:                   resb  16                              ; reserve 16 bytes for the name


section                 .text                                 ; section for storing the actual code
global                  _start                                ; entry point to the label


_start:                 call      _print_text                 ; calling the print function
                        call      _get_name                   ; calling the get name method
                        call      _print_greetings            ; calling the print greetings method
                        call      _print_name                 ; calling print name

                        mov       rax, 60                     ; system call for exit
                        mov       rdi, 0                      ; exit code 0
                        syscall


; --------------------------------------------------------------------------------------------------------
; Custom sub routines
; --------------------------------------------------------------------------------------------------------
_print_text:            mov       rax, 1                      ; function to print hello world
                        mov       rdi, 1                      ; set the file descriptor to the stdout
                        mov       rsi, text                   ; address of the string to the output
                        mov       rdx, text_len               ; number of bytes
                        syscall                               ; execute the operation
                        ret                                   ; return to the caller

_get_name:              mov       rax, 0                      ; set it to read mode
                        mov       rdi, 0                      ; read from the stdin
                        mov       rsi, name                   ; name buffer to print
                        mov       rdx, 16                     ; size of the buffer
                        syscall
                        mov       rbx, rax                    ; save the number of bytes got from the user
                        ret


_print_greetings:       mov       rax, 1                      ; set it to write
                        mov       rdi, 1                      ; set it to print to stdout file descriptor
                        mov       rsi, greetings              ; address of the greetings text
                        mov       rdx, greetings_len          ; count of the buffer
                        syscall
                        ret


_print_name:            mov       rax, 1                      ; set it to write
                        mov       rdi, 1                      ; set it to write to stdout
                        mov       rsi, name                   ; get the address of the name
                        mov       rdx, 16                     ; size of the name 
                        syscall
                        ret
