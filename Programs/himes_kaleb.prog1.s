.data
prompt1: .asciiz "Enter the first number:"
prompt2: .asciiz "Enter the second number:"
part1:   .asciiz "The result of "
part2:   .asciiz " plus "
part3:   .asciiz " is "


.text

main:
#t0 = first number
#t1 = second number
#t2 = sum of $t0 and $t1

#first number
li $v0, 4           # specify print of type "String"
la $a0, prompt1     # load addr of string to print
syscall             # print

li $v0, 5           # specify read of type "Integer"
syscall             # read
move $t0, $v0       # save the integer read in $t0

#second number
li $v0, 4           # specify print of type "String"
la $a0, prompt2     # load addr of string to print
syscall             # print

li $v0, 5           # specify read of type "Integer"
syscall             # read
move $t1, $v0       # save the integer read in $t1

add $t2, $t1, $t0   # compute the sum

#print out sum of $t2
li $v0, 4           # specify print of type "String"
la $a0, part1       # load addr of string to print
syscall             # print part1

li $v0, 1           # specify print of type "Integer"
move $a0, $t0       # load addr of integer to print
syscall             # print first int entered by user

li $v0, 4           # specify print of type "String"
la $a0, part2       # load addr of string to print
syscall             # print part2

li $v0, 1           # specify print of type "Integer"
move $a0, $t1       # load addr of integer to print
syscall             # print second int entered by user

li $v0, 4           # specify print of type "String"
la $a0, part3       # load addr of string to print
syscall             # print part3

li $v0, 1           # specify print of type "Integer"
move $a0, $t2       # load addr of the result for print
syscall             # print the sum of the inputs

Done:
li $v0, 10          # specify "Terminate Program"
syscall             # Terminate
