;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A program to perform a do while loop
;           and also using external libraries from gcc
;---------------------------------------------------------------------------

global    main                          ; entry point to the label
extern    printf, scanf                 ; we are going to use gcc libraries

section   .text                         ; section for storing the actual code
main:
    push rbp                            ; keep the stack aligned
    mov rbp, rsp
    sub rsp, 16                         ; must be 16 byte increments to maintain

    ; ----------------------------------
    ; body of the function

    ; printf(msg)
    xor eax, eax                        ; set 0 to eax to for multiple parameters
    lea rdi, [msg]                      ; first parameter
    call printf

    ; scanf(format, &num)
    mov eax, 0                          ; clear AL (zero FP args in XMM registers)
    lea rdi, [format]                   ; load format string
    lea rsi, [number]                   ; set storage to address of x
    call scanf

    ; int i = 0
    mov DWORD [rbp - 4], 0              ; set 0 to the base pointer with offset of -4


    ; do {
    ;   printf(msg2, i, num);
    ;   i++;
    ; } while (i < num)
loop:
    ; do block with the printf
    xor eax, eax                        ; 0 out the eax
    mov edx, [number]                   ; third parameter
    mov rsi, [rbp - 4]                  ; second parameter
    lea rdi, [msg2]                     ; first parameter, load the string
    call printf

    ; incrementing i++
    mov ecx, DWORD [number]             ; loading i into ecx
    add DWORD [rbp - 4], 1              ; incrementing by 1

    ; while check block
    cmp [rbp - 4], ecx                  ; compare i [rbp - 4] with ecx [number]
    jle loop                            ; jump if i <= number


    ; end of function
    ; ----------------------------------

    add rsp, 16
    leave                               ; mov rsp, rbp; pop rbp
    ret

section   .data                         ; setion for storing variables
    msg:      db "Enter a number: ", 0
    msg2:     db "Looping %d of %d", 10, 0
    format:   db "%d", 0

section   .bss                          ; section for uninitialized data
    number resb 4
