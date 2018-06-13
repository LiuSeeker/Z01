  ;; %D = RAM[1] = CNT
  ;; LED = CNT
  ;; RAM[1] = CNT + 1  
  leaw $1023, %A
  movw %A, %D          
  leaw $21184, %A
  movw %D, (%A)

