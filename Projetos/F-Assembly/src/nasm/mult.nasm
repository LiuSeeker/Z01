;Começando o código...
; Preciso de dois valores para a multiplicação, logo, pegarei R[0] e R[1]
leaw $0, %A
movw (%A), %D
leaw $1, %A
movw (%A), %S
decw %S
;Iterações de soma
WHILE:
leaw $0, %A
;Somar D + A[1] e salva em D
addw  %D, (%A), %D
;Decrementa 1 em %S
decw %S
leaw $WHILE, %A
;Volta se D for maior que zero
jg %S
nop
leaw $2, %A
;Move A[2] -> D
movw %D, (%A)

