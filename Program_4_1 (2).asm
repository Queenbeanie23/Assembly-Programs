;Sabine Wancique
;This program that takes an array of up to 25 elements and returns (1) the number of positives, negatives, 
;and zeroes, (2) the minimum and maximum values, and (3) the sum of the values and the sum of the absolute 
;values. Your program should first ask for the length and test if 1 <= length <= 25
    MaxLen EQU 25
        
%include "io.inc"

section .data     

asklen  db  "Enter the length", 0                   ; length prompt

askfor  db  "Enter ", 0                             ; data prompt
askfor2 db  " integers separated by spaces", 0

output1 db  "Number of Positive Numbers: ", 0                   ; output messages
output2 db  "Number of Negative Numbers: ", 0
output3 db  "The Sum is ", 0
output4 db  "Number of zeros: ", 0
output5 db  "The max number is: ", 0
output6 db  "The Absolute sum is ",0
output7 db  "The Min number is " ,0

lengthErrMsg db "Bad length", 0                     ; error message

section .bss
    A       resd    MaxLen                          ; have to declare with constant length
                                                    ; so allocate the most space that might be needed

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;; get the actual length 
    ;; abd check it's between 1 and MaxLen
        PRINT_STRING    asklen
        NEWLINE
        GET_DEC         4, edx                      ; get length
        cmp             edx, 0                      ; check if >= 1
       ; jle             lengthErr
        cmp             edx, MaxLen                 ; check if <= MaxLen
       ; jg              lengthErr
    

    ;; get the values--prompt
        PRINT_STRING    askfor                      ; prompt for the values
        PRINT_DEC       4, edx
        PRINT_STRING    askfor2
        NEWLINE
        
    ;; get the values--input loop
        mov             ecx, 0                      ; initialize counter
        mov             ebx, 0                      ; initialize offset
       
back1:  cmp             edx, ecx                    ; have them all if counter = theLen
        je              next1                       ; so exit loop
        GET_DEC         4, eax                      ; get the next entry
        mov             [A+ebx], eax                ; store it in the array                        ; push it on the stack
        inc             ecx                         ; increment the counter
        add             ebx, 4                      ; add 4 bytes to offset for next value
        jmp             back1                       ; and go back for next entry
    
    ;; print the amount of positive and negative numbers in the array
    ;; structure is parallel to first loop
    
next1:  mov             ecx, 0                      ;positive counter
        mov             edi, 0                      ;negative counter
        mov             esi, 0                      ;counter
        mov             ebx, 0          
        jmp             next11
next11: ; outputs the number of positive negative and zero numbers in the array
        mov             eax,[A+ebx]  
        cmp             esi, edx
        je              result1                        
        cmp             eax , 0
        je              isZero
        jge             positive
        jl             negative
        
 result1: 
        PRINT_STRING    output1
        PRINT_DEC       4, ecx
        NEWLINE
        PRINT_STRING    output2
        PRINT_DEC       4,edi 
        NEWLINE
        add             ecx,edi
        sub             edx,ecx
        PRINT_STRING    output4
        PRINT_DEC       4,edx
        NEWLINE
        jmp             next2
        
negative:          
         inc             edi
         inc             esi
         add             ebx,4 
         jmp            next11                                       

positive:

        inc             ecx
        inc             esi   
        add             ebx,4 
        jmp             next11
isZero:
        inc esi
        add ebx,4
        jmp             next11
        
next2:
        mov               edx,0
        mov               ecx, 0
        mov               ebx,0    
        jmp              CalcSum

CalcSum:
        mov             eax,[A+ebx]  
        cmp             esi, ecx
        je              return2
        cmp             eax, 0
        add             edx, eax
        inc             ecx
        add             ebx, 4
        jmp           CalcSum
   
return2: ;outputs the sum
        PRINT_STRING    output3
        PRINT_DEC       4, edx
        NEWLINE
        jmp              next3
next3:
        mov               edx,0
       mov                ecx, 0
        mov               ebx,0    
        jmp              CalcAbsSum
CalcAbsSum:
        mov             eax,[A+ebx]  
        cmp             esi, ecx
        je              return3
        cmp             eax, 0
        jl              negation
        add             edx, eax
        inc             ecx
        add             ebx, 4
        jmp           CalcAbsSum
negation:
        neg  eax
        add  edx,eax
        inc  ecx
        add  ebx,4 
        jmp  CalcAbsSum  
return3: ;outputs the sum
        PRINT_STRING    output6
        PRINT_DEC       4, edx
        NEWLINE
        jmp             next4
     
next4:
        mov     ebx,0       ;bit counter
        mov     ecx,0       ;counter
        mov     edx,0       ;current max number
        mov     ebx,0  
        jmp     Max
        
Max:;calculate the max number in the array
        
        cmp     esi, ecx
        je     Return3
        mov     eax,[A+ebx*4]
        add     ebx, 4
        mov     edx,[A+ebx]
        cmp     eax,edx
        jle      meow
        jg      MaxNum
MaxNum:
        mov     edx, eax  
        inc     ecx
        add     ebx,4
        jmp     Max
meow:
Next5:

        mov     ecx,0  ; counter
        mov     edi, 0 ;min num holder
        mov     ebx, 0
        mov     edx, 0
        mov     eax,[A+ebx*4]  
        mov     edx,eax
        add     ebx,4  
        jmp  	Min
       
Min:   
        cmp     esi, ecx
         je     return4
        mov     eax,[A+ebx]
        cmp     edx, eax
        jl       MinVal
 MinVal:
        mov    edi, eax   
        inc     ecx
        add     ebx,4
        jmp     Min
        
             
Return3:
        PRINT_STRING    output5
        PRINT_DEC       4, edx
        NEWLINE 
        jmp            Next5
return4:
        PRINT_STRING   output7
        PRINT_DEC       4, edi
        NEWLINE  
        jmp             endit 
        
lengthErr:
        PRINT_STRING    lengthErrMsg  
        
        
          
                                                            
endit:  NEWLINE
        GET_DEC         4, eax
        xor             eax, eax
        ret