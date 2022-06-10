	.data
	.globl main

message:
	.asciiz "move_one returned: "

board:
	.half 0,0,2,0
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0

buf:
	.word 0,0,0,0

	
	.text

main:
	la $t0 board
	la $t1 buf

   	sw $t0 0($t1)
	addiu $t0 $t0 2
	sw $t0 4($t1)
	addiu $t0 $t0 2
	sw $t0 8($t1)
	addiu $t0 $t0 2
	sw $t0 12($t1)


    la $a0 buf
    la $a1 4
    jal move_one
	
	move $t0 $v0
	la $a0 message
	li $v0 4
	syscall
	move $a0 $t0
    li $v0 1
    syscall
    li $v0 11
    li $a0 10
    syscall

    li $a1 16
    la $a0 board
 	jal print_board_test
	li	$v0 10
	syscall
