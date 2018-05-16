; Arquivo: Factorial.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Calcula o fatorial do número em R0 e armazena o valor em R1.

leaw $R0, %A
movw (%A), %S   
movw (%A), %D   
decw %S
decw %S
leaw $R1, %A
movw %S, (%A)
leaw $R0, %A 
addw (%A), %D, %D 
leaw $R2, %A 
movw %D, (%A) 
decw %S  
leaw $7,%A
jg
nop

leaw $R1, %A
movw (%A), %S
leaw $R0, %A
movw %D, (%A)
decw %S
leaw $R1, %A
movw %S, (%A)
leaw $7, %A
jg
nop

leaw $2, %A
movw (%A), %S
leaw $31, %A
jg
nop

incw %S
leaw $1, %A
movw %S, (%A)