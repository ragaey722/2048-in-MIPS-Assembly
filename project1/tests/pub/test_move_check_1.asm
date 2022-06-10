	.data
	.globl main

message:
	.asciiz "move_check returned: "

board:
	.half 0,2,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0

unmodified_copy:
	.half 0,2,0,0
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
	li $a1 4
	jal move_check
	move $t0 $v0

	la $a0 message
	li $v0 4
	syscall
	move $a0 $t0
	li $v0 1
	syscall

	la $a0 board
	la $a1 unmodified_copy
	li $a2 16
	jal assert_eq_board

	li	$v0 10
	syscall
