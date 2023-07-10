                global solve
                extern printMatrix

                section .data
                INF DD 1000000000 ;1e9

                section .bss
                distances: RESD 25*25
                n RESD 1
                adj RESD 25*25
                nTimes4 RESD 1
                nSquared RESD 1
                i RESD 1
                j RESD 1
                k RESD 1
                temp1 RESD 1
                temp2 RESD 1
                temp3 RESD 1
                temp4 RESD 1

                section .text
setToInf:       mov DWORD [ecx], INF
                jmp l1PostCompare
solve:          mov [n], ebx
                mov [adj], eax

floydWarshall:  mov DWORD [i], 0
                mov eax, [n]
                mov ecx, [n]
                mul ecx
                mov [nSquared], eax
                mov ebx, distances
                mov ecx, [adj]
;               {
l1:                     cmp DWORD [ecx], -1
                        je setToInf
                        mov edx, [ebx]
                        mov [ecx], edx
l1PostCompare:          add ebx, 4
                        add ecx, 4
                        add DWORD [i], 1
                        mov eax, [nSquared]
                        cmp [i], eax
                        jne  l1
;               }
                mov eax, [n]
                mov ecx, 4
                mul ecx
                mov [nTimes4], eax
                mov DWORD [i], 0
;               {
l2:                 mov DWORD [j], 0
;                   {
l3:                     mov DWORD [k], 0
;                       {
l4:                         mov eax, [i]
                            mov ebx, [n]
                            mul ebx
                            mov ebx, eax
                            mov ecx, eax
                            add ebx, [j]
                            add ecx, [k]
                            mov eax, [k]
                            mov edx, [n]
                            mul edx
                            mov edx, eax
                            add edx, [j]
                            add ebx, distances
                            add ecx, distances
                            add edx, distances
                            mov esi, [ebx]
                            mov ecx, [ecx]
                            add ecx, [edx]
                            cmp esi, ecx
                            jge l4PostCompare
                            mov [ebx], ecx
l4PostCompare:              add DWORD [k], 4
                            mov eax, [nTimes4]
                            cmp [k], eax
                            jne l4
;                       }
                        add DWORD [j], 4
                        mov eax, [nTimes4]
                        cmp [j], eax
                        jne l3
;                   }
                    add DWORD [i], 4
                    mov eax, [nTimes4]
                    cmp [i], eax
                    jne l2
;               }
                mov eax, distances
                mov ebx, n
                call printMatrix
                ret


