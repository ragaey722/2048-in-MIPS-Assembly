	.data
	.globl main

board:
	.half 0,0,0,0
	.half 0,2,0,0
	.half 0,0,0,0
	.half 0,0,0,0

buf:
	.word 0,0,0,0

	
	.text

main:
	la $t0 board
	la $t1 buf
    addiu $t0 $t0 8

   	sw $t0 0($t1)
	addiu $t0 $t0 2
	sw $t0 4($t1)
	addiu $t0 $t0 2
	sw $t0 8($t1)
	addiu $t0 $t0 2
	sw $t0 12($t1)


    la $a0 buf
    la $a1 4
    jal complete_move
    la $a0 board
    li $a1 16
 	jal print_board_test
	li	$v0 10
	syscall
