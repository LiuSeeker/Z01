; Arquivo: Factorial.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Calcula o fatorial do número em R0 e armazena o valor em R1.
leaw $R0, %A
movw (%A), %D   
movw (%A), %S   
decw %D
decw %D
leaw $R1, %A
movw %D, (%A)
leaw $R0, %A 
addw (%A), %S, %S 
leaw $R2, %A 
movw %S, (%A) 
decw %D        
leaw $7,%A
jg
nop

leaw $R1, %A
movw (%A), %D   
leaw $R0, %A
movw %S, (%A)   
decw %D
leaw $R1, %A
movw %D, (%A)
leaw $7, %A
jg
nop

leaw $2, %A
movw (%A), %D
leaw $31, %A
jg
nop

incw %D
leaw $1, %A
movw %D, (%A)