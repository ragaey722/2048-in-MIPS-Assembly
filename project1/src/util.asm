.data
	.globl random
	.globl random_init
	.globl print_board_state_oneline

rand:
	.word 0
	
.text

############################
#$v0 new random number
# next = ((next * 110351524 +12345) / (2^16)) % (2^15) 
random:								# pseudo random number
	lw $v0 rand
	mul $v0 $v0 1103515245
	addiu $v0 $v0 12345
	sll $v0 $v0 1
	srl $v0 $v0 17
	sw $v0 rand
	jr	$ra



# $a0 seed
random_init:
	sw $a0 rand
	jr $ra
	
	
# -- print_board_state_oneline --
# (Only used by main to interface with the GUI)
# a0 : board (address of array of half words)
# a1 : size of the board (number of elements in the array a0)
# a2 : points 
# Behaviour:
# Print the board in row major order and seperate fields by a space character.
# Print points (after space).
# Print newline.

print_board_state_oneline: 
	move	$t0 $a0
	
pr2_loop: 
	beqz	$a1 pr2_exit
	lhu	$a0 0($t0)
	# print value
	li	$v0 1
	syscall
	# print space
	li	$v0 11	
	li	$a0 32 # ' '
	syscall
	addiu	$t0 $t0 2
	subiu 	$a1 $a1 1
	b	pr2_loop
	
pr2_exit:
    # print points
	move $a0 $a2
	li	$v0 1
	syscall

	li	$v0 11
	li	$a0 10 # '\n'
	syscall
	jr	$ra