                global read
                global print
                global exit
                global readNumber
                global printNumber
                global newLine
                global printSpace
                global printMatrix
                global pow

                section .data
                length DD 100
                nextLine DB 10,0
                space DB 32, 0
                zeroStr DB '0',0

                section .bss
                numberString RESB 100
                originalOutput RESD 1
                i RESD 1
                i2 RESD 1
                j RESD 1
                temp1 RESD 1
                tempString RESB 100
                matrix RESD 1
                n RESD 1
                m RESD 1
                negative RESD 1

                section .text
makeNegative:   mov DWORD [negative], 1
                jmp l1PostCompare
addMinus:       mov BYTE [numberString], '-'
                mov DWORD [negative], 1
                inc r8d
                neg DWORD [temp1]
                jmp postAddMinus

read:           mov [originalOutput], eax
                mov ecx, eax
                mov edx, length
                mov eax, 3
                mov ebx, 2
                int 80h
                mov ebx, [originalOutput]
                add ebx, eax
                dec ebx
                mov BYTE [ebx], 0
                ret

print:          mov ecx, eax
                call getStringSize
                mov edx, eax
                mov eax, 4
                mov ebx, 1
                int 80h
                ret

exit:           mov eax, 1
                int 80h

readNumber:     mov eax, numberString
                call read
                mov DWORD [negative], 0
                mov DWORD [i], 0
                mov ebx, numberString
                mov eax, 0
                mov DWORD [i], 0
;               {
l1:                     mov ecx, 10
                        mul ecx
                        mov edx, [ebx]
                        movsx edx, dl
                        cmp edx, '-'
                        je makeNegative
                        add eax, edx
                        sub eax, 48 ;'0'
l1PostCompare:          inc DWORD [i]
                        inc ebx
                        cmp BYTE [ebx], 0
                        jne l1
;               }
                cmp DWORD [negative], 1
                jne postNegate
                neg eax
postNegate:     mov ebx, [i]
                ret

printNumber:    cmp eax, 0
                jne printNumberAct
                mov eax, zeroStr
                call print
                ret
printNumberAct: mov DWORD [negative], 0
                mov [temp1], eax
                call getDigitCount
                mov [i], eax
                mov r8d, numberString
                cmp DWORD [temp1], 0
                jl addMinus ;TODO do before get digit count
postAddMinus:   add r8d, [i]
                mov BYTE [r8d], 0
                dec r8d
                dec DWORD [i]
                mov eax, [temp1]
;               {
l2:                     mov edx, 0
                        mov ecx, 10
                        div ecx
                        mov [r8d], dl
                        add BYTE [r8d], '0'
                        dec r8d
                        dec DWORD [i]
                        cmp eax, 0
                        jg l2
;               }
                mov eax, numberString
                call print
                ret

getDigitCount:  mov ebx, 0
;               {
l3:                 mov edx, 0
                    mov ecx, 10
                    div ecx
                    inc ebx
                    cmp eax, 0
                    jne l3
;               }
                mov eax, ebx
                ret

getStringSize:  mov ebx, 0
;               {
l4:                 inc ebx
                    inc eax
                    cmp BYTE [eax], 0
                    jne l4
;               }
                mov eax, ebx
                ret

newLine:        mov eax, nextLine
                call print
                ret

printSpace:     mov eax, space
                call print
                ret

printMatrix:    mov [matrix], eax
                mov [n], ebx
                mov [m], ecx
                mov eax, [n]
                mov edx, 4
                mul edx
                mov [n], eax
                mov eax, [m]
                mov edx, 4
                mul edx
                mov [m], eax
                mov DWORD [i2], 0
;               {
l5:                 mov DWORD [j], 0
;                   {
l6:                     mov eax, [matrix]
                        mov eax, [eax]
                        call printNumber
                        call printSpace
                        add DWORD [j], 4
                        add DWORD [matrix], 4
                        mov eax, [m]
                        cmp [j], eax
                        jne l6
;                   }
                call newLine
                add DWORD [i2], 4
                mov eax, [n]
                cmp [i2], eax
                jne l5
;           }
            ret

pow:        mov ecx, eax
            mov eax, 1
;           {
l7:             mul ecx
                dec ebx
                cmp  ebx, 0
                jne l7
;           }
            ret