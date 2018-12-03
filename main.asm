.data
#space to hold user input
buffer: .space 64

#various strings we will need to output
red: .asciiz "red"
green: .asciiz "green"
blue: .asciiz "blue"
newline: .asciiz "\n"
space: .asciiz " "

#console output strings
redconfirm: .asciiz "received red\n"
greenconfirm: .asciiz "received green\n"
blueconfirm: .asciiz "received blue\n"

#also console output strings
redcounttext: .asciiz "#red: "
greencounttext: .asciiz " #green: "
bluecounttext: .asciiz " #blue: "
totalcounttext: .asciiz " #total: "

#space to hold counts of the colors and total
redcount: .word 0
greencount: .word 0
bluecount: .word 0
totalcount: .word 0

#space to hold the calculated average color values
avgred: .word 0
avggreen: .word 0
avgblue: .word 0


.text
#since this is supposed to be a constantly running processor, the entire main
#is a loop
top:

#at the beginning of each iteration of the loop, calculate the average color
#values and print them out
jal calcavgred
jal calcavggreen
jal calcavgblue
jal printrgb

#read a string of input
li $v0, 8
la $a0, buffer
#max number of characters to read
li $a1, 64
syscall

#check to see if the buffer is the string "red", if so jump
la $a0, buffer
jal checkforred
beq $v0, 1, isred

#check to see if the buffer is the string "green", if so jump
la $a0, buffer
jal checkforgreen
beq $v0, 1, isgreen

#check to see if the buffer is the string "blue", if so jump
la $a0, buffer
jal checkforblue
beq $v0, 1, isblue

#provide a point to jump back to after colors are done processing
#note that if a given input is not "red", "green", or "blue" it will not have
#an appreciable effect on the application
aftercolors:

#at the end of the loop jump back to the start
j top

#function to check if a buffer is the string "red"
isred:
  #print a string to the console confirming that red was received
  li $v0, 4
  la $a0, redconfirm
  syscall

  #increment the red counter by 1
  lw $t1, redcount
  addi $t1, $t1, 1
  sw $t1, redcount

  #increment the total count of colors received by one
  lw $t1, totalcount
  addi $t1, $t1, 1
  sw $t1, totalcount

  #jump back to the main loop after all colors are processed, since a string
  #will only ever be one color
  j aftercolors

isgreen:
  #print a string to the console confirming that green was received
  li $v0, 4
  la $a0, greenconfirm
  syscall

  #increment the count of greens received by one
  lw $t1, greencount
  addi $t1, $t1, 1
  sw $t1, greencount


  #increment the total count of colors received by one
  lw $t1, totalcount
  addi $t1, $t1, 1
  sw $t1, totalcount

  #jump back to the main loop after all colors are processed, since a string
  #will only ever be one color
  j aftercolors

isblue:
  #print a string confirming that blue was received
  li $v0, 4
  la $a0, blueconfirm
  syscall

  #increment the count of blues received by one
  lw $t1, bluecount
  addi $t1, $t1, 1
  sw $t1, bluecount

  #increment the total count of colors received by one
  lw $t1, totalcount
  addi $t1, $t1, 1
  sw $t1, totalcount

  #jump back to the main loop after all colors are processed, since a string
  #will only ever be one color
  j aftercolors

##end of main##

#function checkforred
#determines if a given string is the word "red" by comparing character ascii
#values
#returns 0 in $v0 if the string is not "red", or 1 if it is
checkforred:
  #set a loop counter to 0
  li $t9 0

  redtop:
  #load the buffer address into $t1
  la $t1, ($a0)
  #load the address of "red" into $t2
  la $t2, red

  #on each loop, add the loop counter to the addresses to move to the character
  #being compared in that loop
  #then load the bytes at those addresses
  add $t1, $t1, $t9
  lbu $t3, ($t1)
  add $t2, $t2, $t9
  lbu $t4, ($t2)

  #if the characters (bytes) at those addresses are not the same, then the
  #string is not "red" and we can jump out
  bne $t3, $t4, notred

  #otherwise if the characters match, increment the counter
  addi $t9, $t9, 1

  #if the counter hasn't yet reached 3, i.e the number of characters in "red",
  #jump back to the top of the loop
  bne $t9, 3, redtop

  #if the above bne falls through then the given input is "red"
  #return 1 in $v0 and jump back
  li $v0 1
  jr $ra

  #if at any point the characters don't match then return 0 and jump back
  notred:
  li $v0, 0
  jr $ra

#function checkforgreen
#determines if a given string is the word "green" by comparing character ascii
#values
#returns 0 in $v0 if the string is not "green", or 1 if it is
checkforgreen:
  #set a loop counter to 0
  li $t9 0

  greentop:
  #load the buffer address into $t1
  la $t1, ($a0)
  #load the address of "green" into $t2
  la $t2, green


  #on each loop, add the loop counter to the addresses to move to the character
  #being compared in that loop
  #then load the bytes at those addresses
  add $t1, $t1, $t9
  lbu $t3, ($t1)
  add $t2, $t2, $t9
  lbu $t4, ($t2)

  #if the characters (bytes) at those addresses are not the same, then the
  #string is not "green" and we can jump out
  bne $t3, $t4, notgreen

  #otherwise if the characters match, increment the counter
  addi $t9, $t9, 1

  #if the counter hasn't reached 5, i.e the number of characters in "green",
  #jump back to the top of the loop
  bne $t9, 5, greentop

  #if the above falls through then the given input is "green"
  #return 1 in $v0 and jump back
  li $v0 1
  jr $ra

  #if at any point the characters don't match then return 0 and jump back
  notgreen:
  li $v0, 0
  jr $ra

#function checkforblue
#determines if a given string is the word "blue" by comparing character ascii
#values
#returns 0 in $v0 if the string is not "blue", or 1 if it is

checkforblue:
  #set a loop counter to 0
  li $t9 0

  bluetop:

  #load the buffer address into $t1
  la $t1, ($a0)
  #load the address of "blue" into $t2
  la $t2, blue


  #on each loop, add the loop counter to the addresses to move to the character
  #being compared in that loop
  #then load the bytes at those addresses
  add $t1, $t1, $t9
  lbu $t3, ($t1)
  add $t2, $t2, $t9
  lbu $t4, ($t2)

  #if the characters (bytes) at those addresses are not the same, then the
  #string is not "blue" and we can jump out
  bne $t3, $t4, notblue

  #otherwise if the characters match increment the counter
  addi $t9, $t9, 1


  #if the counter hasn't yet reached 4, i.e the number of characters in "blue",
  #jump back to the top of the loop
  bne $t9, 4, bluetop

  #if the above bne falls through then the given input is "blue"
  #return 1 in $v0 and jump back
  li $v0 1
  jr $ra

  #if at any point the characters don't match then return 0 and jump back
  notblue:
  li $v0, 0
  jr $ra


#function to calculate the weighted rgb value for red given the number of
#responses already
calcavgred:
  #load the count of red responses and the total count, as well as 255
  #which serves as a weight for the RGB value
  lw $t0, redcount
  lw $t1, totalcount
  li $t2, 255

  #multiply the count of red responses by 255
  mult  $t0, $t2
  mflo  $t2

  #divide the resulting value by the total number of responses
  div $t2, $t1
  mflo  $t2

  #store the resulting value
  sw $t2, avgred

  #return to main
  jr $ra

#function to calculate the weighted rgb value for green given the number of
#responses already
calcavggreen:
  #load the count of green responses and the total count, as well as 255
  #which serves as a weight for the RGB value
  lw $t0, greencount
  lw $t1, totalcount
  li $t2, 255

  #multiply the number of red responses by 255
  mult  $t0, $t2
  mflo  $t2

  #divide the resulting value by the total number of responses
  div $t2, $t1
  mflo  $t2

  #store the resulting value
  sw $t2, avggreen

  #return to main
  jr $ra

#function to calculate the weighted rgb value for blue given the number of
#responses already
calcavgblue:
  #load the count of green responses and the total count, as well as 255
  #which serves as a weight for the RGB value
  lw $t0, bluecount
  lw $t1, totalcount
  li $t2, 255

  #multiply the number of blue responses by 255
  mult  $t0, $t2
  mflo  $t2

  #divide the resulting value by the total number of responses
  div $t2, $t1
  mflo  $t2

  #store the resulting value
  sw $t2, avgblue

  #return to main
  jr $ra

#function to print the current calculated rgb values
printrgb:
  #print the red rgb value followed by a space
  li $v0 1
  lw $a0, avgred
  syscall
  li $v0, 11
  lb $a0, space
  syscall

  #print the green rgb value followed by a space
  li $v0 1
  lw $a0, avggreen
  syscall
  li $v0, 11
  lb $a0, space
  syscall

  #print the blue rgb value followed by a space
  li $v0 1
  lw $a0, avgblue
  syscall
  li $v0, 11
  lb $a0, space
  syscall

  jr $ra
