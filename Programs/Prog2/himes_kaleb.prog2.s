#############################################
## Name:  Kaleb Himes                       #
## Email: kaleb.himes@gmail.com             #
#############################################
##                                          #
##  This program prints a bitmap of a       #
##  character based on vector of integers.  #
##                                          #
##  Dimensions: 9 bits x 10 rows            #
##  Mapping:    0 ==> '-'; 1 ==> 'X'        #
##                                          #
##  Variable List:                          #
##    # list variables used in main here    #
##       $t1, a buffer pointer              #
##                                          #
##    # but list all procedure variables    #
##    #             with procedure comments #
##                                          #
##                                          #
############################################# 
.globl main
#############################################
#                                           #
#                   Data                    #
#                                           #
#############################################
.data
testseq: .word 16 56 84 80 48 24 20 84 56 16
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# P = problem, A = which problem, _X = number x of that problem #
# EXAMPLE: PA_1 = Problem A part 1                              # 
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# QUESTION A
dPA_1: .asciiz "PA_1"
PA_1:	.word 60 66 157 293 329 329 334 304 131 124     #Problem A part 1
PA_2: .word 0 56 72 80 102 420 296 274 236 0          #Problem A part 2
#sequence for the letter "A"
PA_3: .word 16 56 40 68 68 130 254 130 130 130        #Problem A part 3
#sequence for the letter "B" 
PA_4: .word 252 130 130 130 252 130 130 130 130 252   #Problem A part 4
# QUESTION B
PB_1: .word 65 34 20 8 20 34 65 0 0 0                 #Problem B part 1
PB_2: .word 8 8 8 127 8 8 8 0 0 0                     #Problem B part 2
# QUESTION C
PC_1: .word 0 60 64 128 128 128 128 64 60 0           #Problem C part 1
PC_2: .word 0 248 132 130 130 130 130 132 248 0       #Problem C part 2
# EXTRA CREDIT
EC: .word 0 15872 31744 63488 61440 61440 63488 31744 15872, 0
#---------------------------------------------------------------#
arraysize: .word 10                                   #Array Size
returnline: .asciiz "\n"                              #return line char
space: .asciiz " "                                    #space char
minus: .asciiz "-"                                    #minus char
ex: .asciiz "X"                                       #X char
shifting: .asciiz "shift"
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# END OF EXPERIMENT PRE-DEFINES                                 #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#---------------------------------------------------------------#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Buffers for storing results of operations on the pre-defined  #
# arrays.                                                       #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
buffer: .word 0:10
buffer_C: .word 0:10
buffer_D: .word 0:10
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# END OF EXPERIMENT BUFFERS                                     #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#############################################
#                                           #
#                  Program                  #
#                                           #
# For experiment replace the line as        #
# specified for whichever test is currently #
# being run.                                #
#############################################
.text
main:
   #Your experiments go here
   lw $s0, arraysize            #all arrays are of size 10, set
#-------------------#
# Problem A part 1  #
#-------------------#
   la $t1, PA_1               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem A part 2  #
#-------------------#
   la $t1, PA_2               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem A part 3  #
#-------------------#
   la $t1, PA_3               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem A part 4  #
#-------------------#
   la $t1, PA_4               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem B part 1  #
#-------------------#
   la $t1, PB_1               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem B part 2  #
#-------------------#
   la $t1, PB_2               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem B part 3  #
#-------------------#
   la $s1, PB_1               #array1 = PB_1
   la $s2, PB_2               #array2 = PB_2
   la $s4, buffer             #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 1           #1 = "and"
   jal someOperation          #store return addr and printchar
   la $t1, buffer             #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#-------------------#
# Problem B part 4  #
#-------------------#
   la $s1, PB_1               #array1 = PB_1
   la $s2, PB_2               #array2 = PB_2
   la $s4, buffer             #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 2           #2 = "or"
   jal someOperation          #store return addr and printchar
   la $t1, buffer             #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#-------------------#
# Problem B part 5  #
#-------------------#
   la $s1, PB_1               #array1 = PB_1
   la $s2, PB_2               #array2 = PB_2
   la $s4, buffer             #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 3           #3 = "xor"
   jal someOperation          #store return addr and printchar
   la $t1, buffer             #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#-------------------#
# Problem C part 1  #
#-------------------#
   la $t1, PC_1               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
# Problem C part 2  #
#-------------------#
   la $t1, PC_2               #get address of sequence[0]
   jal charprint              #store return addr and printchar
#-------------------#
#Problem C part 3  #
#-------------------#
   la $s1, PC_1               #array1 = PC_1
   la $s2, PC_2               #array2 = PC_2
   la $s4, buffer_C           #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 4           #4 = "add"
   jal someOperation          #store return addr and printchar
   la $t1, buffer_C           #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#-------------------#
# Problem C part 4  #
#-------------------#
   la $s1, PC_1               #array1 = PC_1
   la $s2, PC_2               #array2 = PC_2
   la $s4, buffer_D           #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 5           #5 = "subtract"
   jal someOperation          #store return addr and printchar
   la $t1, buffer_D           #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#-------------------#
# Problem C part 5  #
#-------------------#
   la $s1, buffer_C           #array1 = buffer_C
   la $s2, buffer_D           #array2 = buffer_D
   la $s4, buffer             #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 5           #5 = "subtract"
   jal someOperation          #store return addr and printchar
   la $t1, buffer             #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#-------------------#
# Problem C part 6  #
#-------------------#
   la $s1, buffer_C           #array1 = PB_1
   la $s2, buffer_D           #array2 = PB_2
   la $s4, buffer             #buffer for storing result of op
   li $t6, 0                  #ensure $t6 is zero
   addi $t6, $t6, 4           #4 = "add"
   jal someOperation          #store return addr and printchar
   la $t1, buffer             #prepare buffer for charprint
   jal charprint              #call charprint on buffer
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
# ____  _  _  ____  ____   __      ___  ____  ____  ____  __  ____  _  _  _    #   
#(  __)( \/ )(_  _)(  _ \ / _\    / __)(  _ \(  __)(    \(  )(_  _)/ \/ \/ \   #     
# ) _)  )  (   )(   )   //    \  ( (__  )   / ) _)  ) D ( )(   )(  \_/\_/\_/   #   
#(____)(_/\_) (__) (__\_)\_/\_/   \___)(__\_)(____)(____/(__) (__) (_)(_)(_)   #
#                                                                              #
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
   la $t1, EC
   jal charprint
   la $s1, EC                 #load up the extra credit vector
   j animate                  #jump to animate
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
# ____  _  _  ____  ____   __      ___  ____  ____  ____  __  ____  _  _  _    #   
#(  __)( \/ )(_  _)(  _ \ / _\    / __)(  _ \(  __)(    \(  )(_  _)/ \/ \/ \   #     
# ) _)  )  (   )(   )   //    \  ( (__  )   / ) _)  ) D ( )(   )(  \_/\_/\_/   #   
#(____)(_/\_) (__) (__\_)\_/\_/   \___)(__\_)(____)(____/(__) (__) (_)(_)(_)   #
#                                                                              #
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
############################################# 
# Procedure: charprint                      #
#############################################
#    - handles experiment looping           #  
#                                           #
#   - inputs : $t1 our current experiment   #
#   - outputs: none                         #  
#                                           #
#############################################
charprint:
   li $v0, 4                  #4 = "print string"
   la $a0, returnline         #load address of the "\n"
   syscall                    #print the string
   li $t5, 0                  #i for newline = 0
   li $s2, 0                  #zero out the check register
   li $t2, 0                  #i for rowprint = 0
   li $s1, 0                  #zero result register
   addiu $s2, $s2, 256        #initialize or check register 256
   j rowprint                 #run the row print	
#############################################################
# Procedure: rowprint					        #################
#############################################################
#   - prints out the given integer as a     #################
#     single row of bits (0='-' and 1='X"). #################
#										              #################
#   - inputs :                              #################
#              $t1 = experiment             #################
#              $t2 = i for rowprint         #################
#              $t5 = i for newline          #################
#              $s1 = result of "and" check  #################
#              $s2 = bit checking register  #################
#              $s0 = size of array          #################
#   - outputs: prints out 90 strings        #################  
#										              #################
#############################################################
	# complete your procedure body here                      #
   # do not forgot to ample comments!                       #
rowprint:                                                   #
   beq $t2, $s0, newline      #if i == 10, print new line   #
   lw $t7, 0($t1)             #load first element for testing
   #############################################            #
   # Procedure: check, a sub procedure under   #            #
   #            rowprint                       #            #
   #############################################            #
   #   - checks bits 9 - 1 to see if set       #            #
   #   - inputs : $s2, $s1, $t7                #            #
   #   - outputs: result of "and" operation    #            #
   #                                           #            #
   #############################################            #
   check:                                                   #
      beq $s2, $zero, endrow     #if no more bits to check then endrow
      and $s1, $t7, $s2          #check if bit "n" is set   #
      beq $s1, $s2, printex      #if bit is set print "X"   #
      bne $s1, $s2, printminus   #else print "-"            #
   #############################################            #
   # Procedure: printex, a sub procedure under #            #
   #            rowprint                       #            #
   #############################################            #
   #   - print out an "X"                      #            #
   #     array pointer                         #            #
   #   - inputs : $s2                          #            #
   #   - outputs: two strings and $s2 shifted  #            #
   #                                           #            #
   #############################################            #
   printex:                                                 #
      srl $s2, $s2, 1            #prepare for next "check"  #
      la $a0, ex                 #load up "X" for printing  #
      li $v0, 4                  #4=print string            #
      syscall                    #print "X"                 #
      la $a0, space              #load up space for printing#
      li $v0, 4                  #print string              #
      syscall                    #print " "                 #
      j check                    #loop back to "check"      #
   ################################################         #
   # Procedure: printminus, a sub procedure under #         #
   #            rowprint                          #         #
   ################################################         #
   #   - print out an "-"                         #         #
   #     array pointer                            #         #
   #   - inputs : none                            #         #
   #   - outputs: two strings and $s2 shifted     #         #
   #                                              #         #
   ################################################         #
   printminus:                                              #
      srl $s2, $s2, 1            #prepare for next "check"  #
      la $a0, minus              #load up "-" for printing  #
      li $v0, 4                  #4=print string            #
      syscall                    #print "-"                 #
      la $a0, space              #load up space for printing#
      li $v0, 4                  #4=print string            #
      syscall                    #print " "                 #
      j check                    #loop back to "check"      #
   #############################################            #
   # Procedure: endrow, a sub procedure under  #            #
   #            rowprint                       #            #
   #############################################            #
   #   - reset bit checker, advance loop and   #            #
   #     array pointer                         #            #
   #   - inputs : $s2, $s1, $t7                #            #
   #   - outputs: none                         #            #
   #                                           #            #
   #############################################            #
   endrow:                                                  #
      addiu $s2, $s2, 256        #reset check bit in prep for next loop
      addi $t2, $t2, 1           #i for rowprint ++         #
      addi $t1, $t1, 4           #advance array pointer     #
      j newline                  #repeat                    #
#############################################################
## end  of procedure rowprint              ##################
#############################################################
#-------------------------------------------#
############################################# 
# Procedure: newline                        #
#############################################
#    prints a return line                   #  
#                                           #
#############################################
newline:
   li $v0, 4                     #4 = "print string"
   beq $t5, $s0, returnToRA      #if i==10 return to $ra
   addi $t5, $t5, 1              #i for newline ++;
   la $a0, returnline            #load address of the string
   syscall                       #print the string
   j rowprint                    #go to print a new row
############################################# 
# Procedure: returnToRA                     #
#############################################
#   - jump return to $ra                    #
#                                           #
#   - inputs : none                         #
#   - outputs: none                         #  
#                                           #
#############################################
returnToRA:
   jr $ra                        #return to $ra
#############################################################
# Procedure: someOperation                  #################
#############################################################
#   - performs some operation on two  arrays#################
#     stores result in a buffer and calls   #################
#     charprint on that buffer              #################
#     $t6 will be either 1, 2, 3, 4, or 5   #################
#        1 = and                            #################
#        2 = or                             #################
#        3 = xor                            #################
#        4 = add                            #################
#        5 = subtract                       #################
#                                           #################
#   - inputs :                              #################
#              $t5 = i for looping          #################
#              $t6 = operation              #################
#                                           #################
#              $t1 = arg1                   #################
#              $t2 = arg2                   #################
#              $t3 = result                 #################
#                                           #################
#              $s0 = size of array          #################
#              $s1 = array 1 pointer        #################
#              $s2 = array 2 pointer        #################
#              $s4 = buffer pointer         #################
#                                           #################
#   - outputs: new array in $t4             #################  
#                                           #################
#############################################################
someOperation:                                              #
      li $t5, 0                  #i = 0;                    #
   #############################################            #
   # Procedure: loopOp                         #            #
   #############################################            #
   #   - loops the operation through the two   #            #
   #     arrays performing some op on each     #            #
   #     array element stores result in buffer #            #
   #############################################            #
   loopOp:                                                  #
      beq $t5, $s0, returnToRA   #after 10 op's j $ra       #
      lw $t1, 0($s1)             #load array1 [0]           #
      lw $t2, 0($s2)             #load array2 [0]           #
      lw $t3, 0($s4)             #load buffer [0]           #
      beq $t6, 1, and_op         #check which op we're doing#
      beq $t6, 2, or_op          #check which op we're doing#
      beq $t6, 3, xor_op         #check which op we're doing#
      beq $t6, 4, add_op         #check which op we're doing#
      beq $t6, 5, sub_op         #check which op we're doing#
         #############################################      #
         # Procedure: and_op                         #      #
         #############################################      #
         #   - does an "and" operation on two args,  #      #
         #     stores the result in buffer           #      #
         #############################################      # 
         and_op:                                            #
            and $t3, $t1, $t2    #and, $t3 <- result        #
            sw $t3, 0($s4)       #buffer[i] <- $t3          #
            j endloop            #jump to end of loop       #
         #############################################      #
         # Procedure: or_op                          #      #
         #############################################      #
         #   - does an "or" operation on two args,   #      #
         #     stores the result in buffer           #      #
         #############################################      #
         or_op:                                             #
            or $t3, $t1, $t2     #or, $t3 <- result         #
            sw $t3, 0($s4)       #buffer[i] <- $t3          #
            j endloop            #jump to end of loop       #
         #############################################      #
         # Procedure: xor_op                         #      #
         #############################################      #
         #   - does an "xor" operation on two args,  #      #
         #     stores the result in buffer           #      # 
         #############################################      #
         xor_op:                                            #
            xor $t3, $t1, $t2    #xor, $t3 <- result        #
            sw $t3, 0($s4)       #buffer[i] <- $t3          #
            j endloop            #jump to end of loop       #
         #############################################      #
         # Procedure: add_op                         #      #
         #############################################      #
         #   - does an "add" operation on two args,  #      #
         #     stores the result in buffer           #      #
         #############################################      #
         add_op:                                            #
            add $t3, $t1, $t2    #add, $t3 <- result        #
            sw $t3, 0($s4)       #buffer[i] <- $t3          #
            j endloop            #jump to end of loop       #
         #############################################      #
         # Procedure: sub_op                         #      #
         #############################################      #
         #   - does an "sub" operation on two args,  #      #
         #     stores the result in buffer           #      #
         #############################################      #
         sub_op:                                            #
            sub $t3, $t1, $t2    #subtract, $t3 <- result   #
            sw $t3, 0($s4)       #buffer[i] <- $t3          #
            j endloop            #jump to end of loop       #
      #############################################         #
      # Procedure: endloop                        #         #
      #############################################         #
      #   - increments i, advances array pointers #         #
      #############################################         #
      endloop:                                              #
         addi $s1, $s1, 4        #advance pointer on 1      #
         addi $s2, $s2, 4        #advance pointer on 2      #
         addi $s4, $s4, 4        #advance pointer on buffer #
         addi $t5, $t5, 1        #i++;                      #
         j loopOp                                           #
#############################################################
# END OF PROCEDURE: someOperation           #################
#############################################################
#-------------------------------------------#
############################################# 
# Procedure: exit   					           #
#############################################
#   - exit the program                      #
#										              #
#   - inputs : none                         #
#   - outputs: none                         #  
#										              #
#############################################
exit:
	li $v0, 10				            # load $v0 with "Exit program" (10)
	syscall                          # exit
#############################################	
## end program                             ##
#############################################	


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
# ____  _  _  ____  ____   __      ___  ____  ____  ____  __  ____  _  _  _    #   
#(  __)( \/ )(_  _)(  _ \ / _\    / __)(  _ \(  __)(    \(  )(_  _)/ \/ \/ \   #     
# ) _)  )  (   )(   )   //    \  ( (__  )   / ) _)  ) D ( )(   )(  \_/\_/\_/   #   
#(____)(_/\_) (__) (__\_)\_/\_/   \___)(__\_)(____)(____/(__) (__) (_)(_)(_)   #
#                                                                              #
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
############################################# 
# Procedure: animate                        #
#############################################
#   - animate a vector till not on screen   #
#                                           #
#   - inputs :                              #
#              $s0 = size of array          #
#              $s1 = array pointer          #
#                                           #
#              $t1 = arg being manipulated  #
#              $t2 = bit checking register  #
#              $t3 = result of "and" check  #
#              $t4 = exit control           #
#              $t5 = i counter for looping  #
#                                           #
#   - outputs: none                         #  
#                                           #
#############################################
animate:
   li $t2, 0                  #zero $t2
   addiu $t2, $t2, 256        #initialize or check register n = 256
   li $t5, 0                  #set loop counter
   ############################################# 
   # Procedure: animate_begin                  #
   #############################################
   #   - marks an innner looping point         #
   #                                           #
   #   - inputs : none                         #
   #                                           #
   #   - outputs: none                         #  
   #                                           #
   #############################################
   animate_begin:
#exit condition: if we "and" something and the result is zero, increment, if
#                increment reaches 10, all spots are returning zeros and must
#                no longer be being displayed on screen.
      beq $t5, 10, gotoprint           #if checks complete, print.
      lw $t1, 0($s1)                   #load array [0] into $t1
      and $t3, $t1, $t2                #store result of "and" in $t3
      beq $t1, 0, increment            #if result of "and" is zero, increment
      #############################################
      ###----- embedded procedure for exiting ----#
      #############################################
      exit_check:                                 #
         beq $t4, 10, exit             #if $t4 == 10, image is offscreen, exit
         #if no exit then continue                #
      #############################################
      #made it past increment and exit check, let's shift it left and store it.
      srl $t1, $t1, 1                  #shift arg left
      sw $t1, 0($s1)                   #store shifted arg back in array 
      addi $s1, $s1, 4                 #advance array pointer
      addi $t5, $t5, 1                 #i++;
      j animate_begin                  #if not printing yet, repeat
   ############################################# 
   # Procedure: gotoprint                      #
   #############################################
   #   - once we have checked everything, print#
   #                                           #
   #   - inputs : none                         #
   #                                           #
   #   - outputs:                              #
   #              $t2 check bit shifted right  #
   #              $t5 reset to zero            #
   #              $t1 loaded with modified EC  #
   #              $s1 loaded with modified EC  #
   #              $t4 exit control reset       #
   #              $t5 loop counter resest      #  
   #                                           #
   #############################################
   gotoprint:
      srl $t2, $t2, 1                  #shift $t2 right one to check n-1 bit
      li $t5, 0                        #reset the loop counter
      la $t1, EC                       #load extra credit array for printing
      jal charprint                    #print out the character
      la $s1, EC                       #array pointer to beginning for next run
      li $t4, 0                        #zero exit control after each print cycle
      li $t5, 0                        #reset $t5 (i) to zero
      j animate                        #repeat process till off screen
   ############################################# 
   # Procedure: increment                      #
   #############################################
   #   - updates exit control                  #
   #                                           #
   #   - inputs : none                         #
   #                                           #
   #   - outputs: $t4 ++                       #  
   #                                           #
   #############################################
   increment:
      addi $t4, $t4, 1                 #increment by 1 if we have a zero result
      j exit_check
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
# ____  _  _  ____  ____   __      ___  ____  ____  ____  __  ____  _  _  _    #   
#(  __)( \/ )(_  _)(  _ \ / _\    / __)(  _ \(  __)(    \(  )(_  _)/ \/ \/ \   #     
# ) _)  )  (   )(   )   //    \  ( (__  )   / ) _)  ) D ( )(   )(  \_/\_/\_/   #   
#(____)(_/\_) (__) (__\_)\_/\_/   \___)(__\_)(____)(____/(__) (__) (_)(_)(_)   #
#                                                                              #
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#