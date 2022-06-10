	.data
	.globl main

message:
	.asciiz "place returned: "

board:
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	
	.text

main:
	la $a0 board
	li $a1 16
	li $a2 0
	li $a3 2
	jal place	
	move $t0 $v0
	la $a0 message
	li $v0 4
	syscall
	move $a0 $t0
	li $v0 1
	syscall
	li	$v0 11	
	li	$a0 10 # '\n'
	syscall
	la $a0 board
	li $a1 16
	jal print_board_test
	li	$v0 10
	syscall
