.globl main
.data
a: .word 10         # $V0 = 4
.text
main:
la $t0, a           # $t0 = 10010000
addi $8, -4	        # update: $t0 = 1000fffc
lw $9, 4($t0)       # $t1 = a
li $t4, 4           # $t4 = 4
addi $t2, $12, 0    # $t2 = 4
sub $t0, $9, $t2    # update: $t0 = 6
addi $t3, $8, 8     # $t3 = e
addi $11, $t3, 0	   #   update: $t3 = e (again)
add $4, $t3, $zero	# $a0 = e (R4)
addi $v0, $zero, 1 	# update: $v0 = 1
syscall             # console call
li $v0, 10          # "or immediate" binary 10 and binary 1
syscall             # result is binary 14, publish this on the console
