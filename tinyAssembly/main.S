;Purpose:   To determine if a value is greater than 127
;Reference: http://darcy.rsgc.on.ca/ACES/TEI4M/1718/AssemblyTasks.html#Test1
;Author:    2017-2018 TEI4M  
;Date:      2017 11 16
;Status:    Working 

.global mySetup
mySetup:
  ldi   r16,1<<5|1<<4     ;must prepare BOTH d13 & d12 for output (Bicolor LED)
  out   0x04,r16          ;do it

  ldi   r20,128           ;sample data...
  cpi   r20,127           ;establish the benchmark
  brpl  greater           ;if data-127>0 must present green            
  rcall red               ;present red
  rjmp wait               ;
greater:
  rcall green             ;
wait:
  rjmp wait               ;twiddle your thumbs...
  ret

.global green
green:
  ldi   r16,1<<5          ;prepare to set d13 and clear d12 
  out   0x05,r16
  ret  

.global red
red:
  ldi   r16,1<<4          ;prepare to set d12 and clear d13 
  out   0x05,r16          ;do it
  ret

.global loop         ;must have (Arduino IDE expects it)
loop:
  ret
