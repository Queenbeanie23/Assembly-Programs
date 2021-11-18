;;; Multiplies an integer by 13 = 1101

%include "io.inc"

section .data

inputmsg            db              "Enter an integer: ", 0
outputmsg           db              "13 times your integer is: ", 0

section .text
global CMAIN
CMAIN:
    PRINT_STRING    inputmsg
    GET_DEC         4, eax
    
    mov             esi, eax        ; esi = eax
    sal             esi, 1          ; esi = 2*eax
    add             esi, eax        ; esi = 3*eax
    sal             esi, 2          ; esi = 12*eax
    add             esi, eax        ; esi = 13*eax
    PRINT_STRING    outputmsg
    PRINT_DEC       4, esi
    NEWLINE
    GET_DEC         4, eax          ; close the window
    
    xor eax, eax
    ret