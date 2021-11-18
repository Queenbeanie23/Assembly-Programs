;;; 

%include "io.inc"

section .data

inputmsg1           db              "Enter an integer x: ", 0
inputmsg2           db              "Enter another integer y: ", 0
inputmsg3           db              "Enter a third integer z: ", 0
outputmsg           db              "3x-8y+5z-4 is: ", 0

section .text
global CMAIN
CMAIN:
    PRINT_STRING    inputmsg1
    GET_DEC         4, eax
    PRINT_STRING    inputmsg2
    GET_DEC         4, ebx
    PRINT_STRING    inputmsg3
    GET_DEC         4, ecx
    PRINT_STRING    inputmsg2
    
    mov             esi, eax        ; esi = eax
    sal             esi, 1          ; esi = 2*eax
    add             esi, eax        ; esi = 3*eax

   mov             edi, ebx          ;edi = ebx
   sal             edi, 3            ; edi = 8 * ebx
   neg             edi               ; this negate 8 into -8
    
   add             esi, edi        ;add esi and edi and than resuse edi
   
   mov             edx, ecx        ;edx=ecx
   sal             edx, 2         ;edi=4*ecx
   add             edx, ecx         ;edi=5*ecx
    
    
    add             esi, edx        ; add the esi and edx and store the result in esi
    
   sub              esi, 4           ; take the result and subtract  it by 4
   
   
    PRINT_STRING    outputmsg
    PRINT_DEC       4, esi
    NEWLINE
    GET_DEC         4, eax          ; close the window
    
    xor eax, eax
    ret