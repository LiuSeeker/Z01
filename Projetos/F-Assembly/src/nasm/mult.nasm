leaw $R0, %A
movw (%A), %S
leaw $R1, %A
movw (%A), %D

WHILE:
leaw $END, %A
jle
nop

leaw $R0, %A
movw (%A), %S
leaw $R3, %A
addw (%A), %S, %S
leaw $R3,%A
movw %S, (%A)
decw %D
leaw $WHILE, %A
jmp
nop

END:
