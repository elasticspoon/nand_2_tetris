// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.
// MAIN_LOOP
//   IF KEYBOARD > 0
//     SET FILL -1
//   ELSE
//     SET FILL 0
//   END
//
//   i = SCREEN
//
//   FILL_LOOP
//     IF I - KEYBOARD >= 0
//       GOTO MAIN_LOOP
//
//     SCREEN[i] = FILL
//     i++
//     GOTO FILL_LOOP

(MAIN_LOOP)
  // fill_value = 0 (white)
  @fill_value
  M=0

  // if keyboard not pressed GOTO NOT_PRESSED
  @KBD
  D=M
  @NOT_PRESSED
  D;JEQ
  (PRESSED)
  // set fill_value = -1 (black)
  @fill_value
  M=-1
  (NOT_PRESSED)

  // i = SCREEN_OFFSET
  @SCREEN
  D=A
  @i
  M=D

  (FILL_LOOP)
    // IF i >= KBD_OFFSET restart main loop
    @KBD
    D=A
    @i
    D=D-M
    @MAIN_LOOP
    D;JLE

    // SCREEN[i] = fill_value
    @fill_value
    D=M
    @i
    A=M
    M=D

    // i++
    @i
    M=M+1

    // GOTO FILL_LOOP
    @FILL_LOOP
    0;JMP


