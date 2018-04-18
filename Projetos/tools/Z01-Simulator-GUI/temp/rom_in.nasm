leaw $0, %A
movw (%A), %D
leaw $1, %A
subw %D, (%A), %S
leaw $MENOR, %A
jg %S
nop
movw $0, %D
leaw $1, %A
movw (%A), %D
leaw $2, %A
movw %D, (%A)
leaw $END, %A
jmp
MENOR:
leaw $2, %A
movw %D, (%A)
END:


















































































