.data
	.globl printboard
seperator: 
 	.asciiz  "-----------------------------\n"
empty_row:
	.asciiz  "|      |      |      |      |\n"
row_begin:
 	.asciiz  "| "
row_end:
 	.asciiz  "|\n"
space:
	.asciiz  " "
#
#a0 Address of the first field of the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#
.text
printboard:
li $a1 16
move $a2 $a0

loop:
la $a0 seperator
li $v0 4
syscall
blez $a1 finish_print 

la $a0 empty_row
li $v0 4
syscall


li $t1 3

print_row:
li $t0 1
la $a0 row_begin
li $v0 4
syscall
lhu $t2 ($a2)
move $t3 $t2
addiu $a2 $a2 2
addiu $a1 $a1 -1
bgeu $t2 10 count_digits
b print_spaces
print_number:
move $a0 $t2
li $v0 1
syscall
la $a0 space
li $v0 4
syscall
addiu $t1 $t1 -1
bgez $t1 print_row


continue:
la $a0 row_end
li $v0 4
syscall

la $a0 empty_row
li $v0 4
syscall
b loop


finish_print:
    jr $ra

count_digits:
addiu $t0 $t0 1
divu  $t3 $t3 10
bgeu  $t3 10 count_digits

print_spaces:
bgeu $t0 4 print_number
la $a0 space
li $v0 4
syscall
addiu $t0 $t0 1
b print_spaces




