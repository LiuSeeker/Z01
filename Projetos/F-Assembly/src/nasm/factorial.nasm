leaw $R0, %A
movw (%A), %D   ; D=RAM(%A)
movw (%A), %S   ; S=RAM(%A)
decw %D
decw %D
leaw $R1, %A
movw %D, (%A)
leaw $R0, %A ; LINHA jump
addw (%A), %S, %S ; soma A com S e salva em R3
leaw $R2, %A ; LINHA jump
decw %D         ; diminui D em 1
leaw $7,%A
jg
nop
leaw $R1, %A
movw (%A), %D   ; D=RAM(%A)
leaw $R0, %A
movw %S, (%A)   ; S=RAM(%A)
decw %D
leaw $R1, %A
movw %D, (%A)
leaw $7, %A
jg
nop
leaw $2, %A
movw (%A), %D
leaw $1, %A
movw %D, (%A)
