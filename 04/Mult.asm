// Mult.asm : The inputs of this program are the values stored in R0
// and R1 (RAM[0] and RAM[1]). The program computes the product R0 * R1 and stores the result in
// R2 (RAM[2]). Assume that R0 ≥ 0, R1 ≥ 0, and R0 * R1 < 32768 conditions). 
// i = 0
// sum = 0
// (LOOP)
//   sum = sum + m   
//   i = i + 1
//   if i - n < 0 GOTO LOOP
@i
M=0
@R2
M=0

(LOOP)
  @i
  D=M
  @R0
  D=D-M
  @EXIT
  D;JGE

  // sum = sum + n
  @R2
  D=M
  @R1
  D=D+M
  @R2
  M=D

  // i++
  @i
  M=M+1

  @LOOP
  0;JMP


(EXIT)
  @EXIT
  0;JMP
