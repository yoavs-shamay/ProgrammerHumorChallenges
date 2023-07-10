                global solve
                extern printMatrix

                section .data
                infinity DD 1000000000 ;1e9

                section .bss
                distances: RESD 625 ;25*25
                prevShortestPath: RESD 25*25
                n RESD 1
                adj RESD 1
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
setToInfinity:  mov esi, [infinity]
                mov DWORD [ecx], esi
                jmp l1PostCompare
solve:          mov [n], ebx
                mov [adj], eax

floydWarshall:  mov eax, [n]
                mov ecx, [n]
                mul ecx
                mov [nSquared], eax
                mov ebx, [adj]
                mov ecx, distances
                mov r8d, prevShortestPath
                mov DWORD [i], 0
;               {
l1:                     cmp DWORD [ebx], -1
                        je setToInfinity
                        mov esi, [ebx]
                        mov [ecx], esi
                        mov eax, [i]
                        mov edx, 0
                        div DWORD [n]
                        mov [r8d], eax
l1PostCompare:          add ebx, 4
                        add ecx, 4
                        add r8d, 4
                        inc DWORD [i]
                        mov eax, [nSquared]
                        cmp [i], eax
                        jne  l1
;               }
                mov eax, [n]
                mov ecx, 4
                mul ecx
                mov [nTimes4], eax
                mov DWORD [k], 0
;               {
l2:                 mov DWORD [i], 0
;                   {
l3:                     mov DWORD [j], 0
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
                            mov r8d, [ecx]
                            add r8d, [edx]
                            cmp esi, r8d
                            jle l4PostCompare
                            mov [ebx], r8d
                            sub ebx, distances
                            sub edx, distances
                            add ebx, prevShortestPath
                            add edx, prevShortestPath
                            mov edx, [edx]
                            mov [ebx], edx
l4PostCompare:              add DWORD [j], 4
                            mov eax, [nTimes4]
                            cmp [j], eax
                            jne l4
;                       }
                        add DWORD [i], 4
                        mov eax, [nTimes4]
                        cmp [i], eax
                        jne l3
;                   }
                    add DWORD [k], 4
                    mov eax, [nTimes4]
                    cmp [k], eax
                    jne l2
;               }
                mov eax, distances
                mov ebx, [n]
                call printMatrix
                mov eax, prevShortestPath
                mov ebx, [n]
                call printMatrix
                ret


