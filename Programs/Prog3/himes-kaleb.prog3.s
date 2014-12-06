#############################################
## Name:  Lab 3 Program                     #
## Email: kaleb.himes@gmail.com             #
#############################################
##                                          #
##  This program produces a Lucas sequence  #
##  of the first (U) or second (V) order,   #
##  given a number N, and constants         #
##  P and Q.                                #
##                                          #
############################################# 

.globl main

#############################################
#                                           #
#                   Data                    #
#                                           #
#############################################
.data
   menuWelcomeMessage:  .asciiz "Lucas Sequence Generator: \n\n"
   menuOption1message:  .asciiz "  (1) U(n, P, Q)\n\n"
   menuOption2message:  .asciiz "  (2) V(n, P, Q)\n\n"
   menuOption3message:  .asciiz "  (3) Exit the program\n\n"	
   selectionMessage:    .asciiz "Enter your selection: "
   requestNmessage:     .asciiz "Please enter integer  N: "
   requestPmessage:     .asciiz "Please enter constant P: "
   requestQmessage:     .asciiz "Please enter constant Q: "	
   newline:             .asciiz "\n"
   notYetImplemented_U: .asciiz "\nU procedure is not yet implemented!\n"
   notYetImplemented_V: .asciiz "\nV procedure is not yet implemented!\n"
   exitMessage:         .asciiz "\nThank you, come again!"
   comma_space:         .asciiz ", "
   return_line:         .asciiz "\n"

.text
#############################################
#                                           #
#                  Program                  #
#                                           #
#############################################
main:
   la $a0, menuWelcomeMessage # load menu introductory message
   jal printString            # print message

   la $a0, menuOption1message # load menu prompt 1
   jal printString            # print message

   la $a0, menuOption2message # load menu prompt 2
   jal printString            # print message

   la $a0, menuOption3message # load menu prompt 3
   jal printString            # print message

   la $a0, selectionMessage   # load message for menu selection input
   jal scanInteger            # print selection prompt and get user input
   addi $a3, $v0, -1          # adjust result to make zero-indexed (0 or 1), 
                              # and store value in $a3

   la $a0, newline            # print a newline \n
   jal printString         

   li $t0, 1                  # load temp value for range testing
   blt $t0, $a3, __sysExit    # user entered int > 2; exit program
   blt $a3, $0, __sysExit     # user entered int < 1; exit program

   la $a0, requestNmessage    # load message to enter integer N
   jal scanInteger            # print selection prompt and get user input
   move $s0, $v0              # store n in $s0 (for now)

   la $a0, requestPmessage    # load message to enter integer P
   jal scanInteger            # print selection prompt and get user input
   move $a1, $v0              # store P in $a1

   la $a0, requestQmessage    # load message to enter integer Q
   jal scanInteger            # print selection prompt and get user input
   move $a2, $v0              # store Q in $a2	

   move $t3, $s0              # copy n from $s0 to $t3
   li $a0, 0                  # set $a0 to zero

printloop:
   beq $a0, $t3, endloop      # if $a0 = N exit loop
   addi $t2, $a0, 0           # store current value of $a0
   jal lucasSequence          # get the current number for current $a0
   addi $a0, $v0, 0           # load result for print
   beq $a3, 1, print_v        # if function v print v instead
   j the_rest                 # else jump to the rest
   print_v:                   
      beq $a0, 0, load_2      # if we would print a zero
      j the_rest              # else jump to the rest
      load_2:
         addi $a0, $a0, 2     #load 2 for print instead of 0
   the_rest:
      li $v0,1                # print an integer
      syscall                 # print final result
      addi $a0, $t2, 1        # restore $a0, add 1
      beq $a0, $t3, lastPrint # if we're on last don't print comma_space
      bne $a0, $t3, notLast   # if not last print, no return
      notLast:
         la $a0, comma_space  # print a comma, space
         jal printString      # print a comma, space
         j continueLoop       # jump to end of loop
      lastPrint:  
         la $a0, return_line  # print return line
         jal printString      # print return line
      continueLoop:
         addi $a0, $t2, 1     # restore $a0 to value before print +1

   j printloop

endloop:
   la $a0, newline            # print a newline \n
   jal printString

   j main                     # loop to main menu again


############################################# 
# Procedure: lucasSequence                  #
#############################################
#   - produces the Lucas sequence of the    #
#     first (U) or second (V) order for     #
#     given constants P and Q.              #
#                                           #
#     The procedure produces all numbers    #
#     in the sequence U or V from n=0       #
#     up to n=N.                            #
#                                           #
#   - inputs : $a0-integer N                #
#              $a1-constant P               #
#              $a2-constant Q               #
#              $a3-function U (0) or V (1)  #
#   - outputs: none                         #
#                                           #
#############################################
lucasSequence:
   addi $sp, $sp, -8          # allocate 2 places on stack
   sw $ra, 4($sp)             # save our return addr
   addi $v0, $a0, 0           # store n in $v0, modify as we go
   blt $a0, 2, LSN_ret        # if n < 2 branch, else continue
   sw $a0, 0($sp)             # save n in the stack
   addi $a0, $a0, -1          # reduce n by 1
   jal lucasSequence          # first recursion bottomed
   lw $a0, 0($sp)             # restore n to it's previous state
   sw $v0, 0($sp)             # save result of lsn(n-1)
   addi $a0, $a0, -2          # reduce n by 2
   jal lucasSequence          # second recursion bottomed
   lw $v1, 0($sp)             # get result of lsn(n-2)
   beq $a3, 1, lsn_v          # if doing v then go to lsn_v
   j continue                 # else doing u ignore

   lsn_v:                  
      beq $v0, 0, l_2_v0      # check for base case $v0
      beq $v1, 0, l_2_v1      # check for base case $v1
      j continue              # if not base, skip
      l_2_v0:
         li $v0, 2            # load two into $v0
         beq $v1, 0, l_2_v1   # check for base case $v1
         j continue           # jump to continue
      l_2_v1:
         li $v1, 2            # load two into $v1
         beq $v0, 0, l_2_v0   # check for base case $v0

   continue:
      mult $v1, $a2           # multiply $v1 by q, store in $v1
      mflo $v1                # get result of mult in $v1
      mult $v0, $a1           # multiply $v0 by p, store in $v0
      mflo $v0                # get result of mult in $v0
      sub $v0, $v0, $v1       # $v0 <- p*LSN(n-1) - q*LSN(n-2)
   

LSN_ret:

   lw $ra,4($sp)              # read registers from stack
   addi $sp,$sp,8             # bring back stack pointer
   jr $ra


############################################# 
# Procedure: scanInteger                    #
#############################################
#   - prints a message and gets an integer  #
#     from user                             #
#                                           #
#   - inputs : $a0-address of string prompt #
#   - outputs: $v0-integer return value     #
#                                           #
#############################################
scanInteger:
   addi $sp, $sp, -4          # adjust stack
   sw $ra, 0($sp)             # push return address
   jal printString            # print message prompt

   li $v0, 5                  # read integer from console
   syscall                    # read in

   lw $ra, 0($sp)             # pop return address
   addi $sp, $sp, 4           # adjust stack
   jr $ra                     # return
############################################# 
# Procedure: printString                    #
#############################################
#   - print a string to console             #
#                                           #
#   - inputs : $a0 - address of string      #
#   - outputs: none                         #
#                                           #
#############################################
printString:
   li $v0, 4
   syscall
   jr $ra

#############################################
# Procedure: printLN   (print Lucas Number) #
#############################################
#   - print a string to console             #
#                                           #
#   - inputs : $a0 - address of string      #
#   - outputs: none                         #
#                                           #
#############################################
printLN:
   li $v0, 1                  # specify print of type "Integer"
   lw $a0, 0($t0)             # load n from $t0 into $a0 for print
   syscall                    # print n
   li $v0, 4                  # 4 = "print a string"
   la $a0, comma_space        # load a comma and a space for print
   syscall                    # print out the comma and space
   jr $ra                     # return from whence we came
#############################################
# Procedure: __sysExit                      #
#############################################
#   - exit the program                      #
#                                           #
#   - inputs : none                         #
#   - outputs: none                         #
#                                           #
#############################################
__sysExit:
   la $a0, exitMessage        # print exit message
   jal printString            # print the string
   li $v0, 10                 # exit program call
   syscall                    # execute call
