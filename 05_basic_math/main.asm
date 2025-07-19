;---------------------------------------------------------------------------
; Author  - Piush Bose <dev.bosepiush@gmail.com>
; Subject - A simple assembly program to perform basic math operations
;---------------------------------------------------------------------------

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

section     .text
global      _start

_start:
            ; ----------------------------------------------------
            ; Division: 7 / 2
            xor     rdx, rdx                  ; clear out rdx to store the remainder
            mov     rax, 7
            mov     rbx, 2
            div     rbx                       ; quotient in rax, remainder in rdx

            push    rdx                       ; save remainder first
            push    rax                       ; save quotient on top

            call    _quo

            pop     rax                       ; pop quotient
            call    _print_rax                ; print quotient

            call    _rem
            pop     rax                       ; pop remainder
            call    _print_rax
            call    _newline

            ; ----------------------------------------------------
            ; Multiplication: 7 * 3
            mov       rax, 7
            mov       rbx, 3
            mul       rbx                     ; rax = rax * rbx

            push      rax                     ; save the state of rax onto the stack

            call      _ans

            pop       rax
            call      _print_rax
            call      _newline

            ; ----------------------------------------------------
            ; Addition: 7 + 3
            mov       rax, 7
            mov       rbx, 3
            add       rax, rbx

            push      rax

            call      _ans

            pop       rax
            call      _print_rax
            call      _newline

            ; ----------------------------------------------------
            ; Subtraction: 7 - 3
            mov       rax, 7
            mov       rbx, 3
            sub       rax, rbx

            push      rax

            call      _ans

            pop       rax
            call      _print_rax
            call      _newline

            ; ----------------------------------------------------
            ; Exit
            mov       rax, 60
            xor       rdi, rdi
            syscall

; ---------------------------------------------------------------
; Subroutine to print value in rax as ASCII string
; Converts rax to string, stores it in [buffer], and prints it
; ---------------------------------------------------------------
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

; ---------------------------------------------------------------
; Subroutine to print a newline
; ---------------------------------------------------------------
_newline:
            mov     rax, 1
            mov     rdi, 1
            mov     rsi, newline
            mov     rdx, 1
            syscall
            ret

; ---------------------------------------------------------------
; Sub routine to print pretty things about the division
; ---------------------------------------------------------------
_quo:
            mov     rax, 1
            mov     rdi, 1
            mov     rsi, quo
            mov     rdx, quo_len
            syscall
            ret

_rem:
            mov     rax, 1
            mov     rdi, 1
            mov     rsi, rem
            mov     rdx, rem_len
            syscall
            ret

_ans:
            mov     rax, 1
            mov     rdi, 1
            mov     rsi, ans
            mov     rdx, ans_len
            syscall
            ret
