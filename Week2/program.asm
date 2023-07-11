                global solve
                extern printMatrix
                extern pow
                extern printNumber
                extern printSpace
                extern newLine
                extern exit

                section .data
                infinity DD 1000000 ;1e6
                dp times 10240 DD 1000000 ;25*2^25, temporarily less
                nextTSP times 10240 DD -1 ;25*2^25

                section .bss
                distances: RESD 625 ;25*25
                prevShortestPath: RESD 25*25
                n RESD 1
                adj RESD 1
                nTimes4 RESD 1
                nSquared RESD 1
                twoPowN RESD 1
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
                mov ecx, [n]
                call printMatrix
                mov eax, prevShortestPath
                mov ebx, [n]
                mov ecx, [n]
                call printMatrix
                call newLine
tsp:            mov eax, 2
                mov ebx, [n]
                call pow
                mov [twoPowN], eax
                mov DWORD [i], 0
                mov eax, dp
;               {
l5:                 mov DWORD [eax], 0
                    add eax, 4
                    inc DWORD [i]
                    mov ebx, [n]
                    cmp [i], ebx
                    jne l5
;               }
                mov esi, eax
                mov edi, eax
                sub edi, dp
                add edi, nextTSP
                mov edx, 0
                mov DWORD [i], 1
;               {
l6:                 mov DWORD [j], 0
;                   {
l7:                     mov DWORD [k], 0
;                       {
l8:                         mov ebx, 1
                            mov ecx, [k]
                            shl ebx, cl
                            mov ecx, [i]
                            and ecx, ebx
                            cmp ecx, 0
                            je l8End
                            mov eax, [j]
                            mov edx, [n]
                            mul edx
                            add eax, [k]
                            mov edx, 4
                            mul edx
                            add eax, distances
                            mov eax, [eax]
                            cmp eax, [infinity]
                            je l8End
                            mov r8d, eax
                            mov eax, [i]
                            xor eax, ebx
                            mul DWORD [n]
                            add eax, [k]
                            mov edx, 4
                            mul edx
                            add eax, dp
                            mov eax, [eax]
                            add eax, r8d
                            cmp [esi], eax
                            jle l8End
                            mov ebx, [k]
                            mov [edi], ebx
                            mov [esi], eax
l8End:                      inc DWORD [k]
                            mov eax, [n]
                            cmp [k], eax
                            jne l8
;                       }
                        add edi, 4
                        add esi, 4
                        inc DWORD [j]
                        mov eax, [n]
                        cmp [j], eax
                        jne l7
;                   }
                inc DWORD [i]
                mov eax, [twoPowN]
                cmp [i], eax
                jne l6
;           }
            call newLine
            call newLine
            mov ebx, [infinity]
            mov ecx, [twoPowN]
            dec ecx
            mov esi, -1
            mov DWORD [i], 0
;           {
l9:             mov eax, ecx
                mov edi, 1
                mov [temp1], ecx
                mov ecx, [i]
                shl edi, cl
                mov ecx, [temp1]
                xor eax, edi
                mul DWORD [n]
                add eax, [i]
                mov edx, 4
                mul edx
                add eax, dp
                cmp [eax], ebx
                jge l9PostCompare
                mov ebx, [eax]
                mov esi, [i]
l9PostCompare:  inc DWORD [i]
                mov eax, [n]
                cmp [i], eax
                jne l9
;           } 
            mov [temp1], ebx
            mov [temp2], esi
            mov eax, [temp1]
            call printNumber
            call printSpace
            mov eax, [temp2]
            call printNumber
            call newLine
            call newLine
            mov eax, dp
            mov ebx, [twoPowN]
            mov ecx, [n]
            call printMatrix
            call newLine
            ret


                    


