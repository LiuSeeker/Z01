; Arquivo: Pow.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Eleva ao quadrado o valor da RAM[1] e armazena o resultado na RAM[0].
; Só funciona com números positivos


leaw $R1, %A
movw (%A), %D   
movw (%A), %S 
decw %D
leaw $R1, %A
decw %D
addw (%A), %S, %S
leaw $R4, %A
jg
nop
leaw $R0,%A
movw %S, (%A)