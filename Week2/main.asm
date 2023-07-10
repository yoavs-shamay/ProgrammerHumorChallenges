        global _start
        extern solve
        extern read
        extern print
        extern exit
        extern readNumber
        extern printNumber
        extern newLine
        extern printSpace
        extern printMatrix

        section .data
        length DD 100

        section  .bss
        n RESD 1
        temp1 RESD 1
        adj RESD 25*25
        i RESD 1
        j RESD 1


        section .text
_start: call readNumber
        mov [n], eax
        mov DWORD [i], 0
;       {
l1:             mov DWORD [j], 0
;               {
l2:                     call readNumber
                        mov [temp1], eax
                        mov eax, [i]
                        mov ecx, [n]
                        mul ecx
                        add eax, [j]
                        mov ecx, 4
                        mul ecx
                        add eax, adj
                        mov ebx, [temp1]
                        mov [eax], ebx
                        inc DWORD [j]
                        mov eax, [n]
                        cmp [j], eax
                        jne l2
;               }
                inc DWORD [i]
                mov eax, [n]
                cmp  [i], eax
                jne l1
;       }
        mov eax, adj
        mov ebx, [n]
        call solve
        call exit