; Arquivo: Mod.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Divide o número posicionado na RAM[1] pelo número posicionado no RAM[2] e armazena o resultado na RAM[0].

leaw $1, %A
movw (%A), %S
movw %S, %D

WHILE:
leaw $END, %A
jl %D
nop

leaw $ENDD, %A
je %D
nop

movw %D, %S
leaw $2, %A
subw %S, (%A), %D
leaw $WHILE, %A
jmp
nop

END:
leaw $0, %A
movw %S, (%A)
leaw $ENDEND, %A
jmp
nop

ENDD:
movw %D, %S
leaw $0, %A
movw %S, (%A)
leaw $ENDEND, %A
jmp
nop

ENDEND:
