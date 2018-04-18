

leaw $0, %A
;Mover o que ta em A[0] para D
movw (%A), %D

WHILE:
leaw $1, %A
;Subtrai D - A[1] e salva em D
subw  %D, (%A), %D
;Incrementa 1 em %S
incw %S
leaw $WHILE, %A
;Volta se D for maior que zero
jg %D
nop
leaw $2, %A
;Move A[2] -> S
movw %S, (%A)


























































































