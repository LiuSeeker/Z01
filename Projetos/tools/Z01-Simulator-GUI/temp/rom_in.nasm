leaw $0, %A
movw (%A), %D
WHILE:
leaw $1, %A
subw  %D, (%A), %D
incw %S
leaw $WHILE, %A
jg %D
nop
leaw $2, %A
movw %S, (%A)


























































































