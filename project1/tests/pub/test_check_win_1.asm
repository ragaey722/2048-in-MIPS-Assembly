	.data
	.globl main

message:
	.asciiz "check_victory returned: "

board:
	.half 2048,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0

unmodified_copy:
	.half 2048,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	
	.text

main:
	la $a0 board
	li $a1 16
	jal check_victory
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
