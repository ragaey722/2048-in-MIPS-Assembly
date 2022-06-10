.data
    .globl assert_eq_board
    .globl print_board_test

message_size:
    .asciiz "Board Size: "

message_content:
	.asciiz "Board Content: "

error_message:
	.asciiz "\Assertion failed: Board was modified!"

.text

# -- assert_eq_board --
# a0 : board 1 (address of array of half words)
# a1 : board 2 (address of array of half words)
# a2 : size of both boards (number of elements in the array a0 and a1)
# Behaviour:
# Check if the board states are equal. If not, print the
# message "Assertion failed: Board was modified!" and exits the program.

assert_eq_board:
    li $t0 0    
	
e_loop:
    bge $t0 $a2 success
	lhu $t1 ($a0)
    lhu $t2 ($a1)
	bne $t1 $t2 exit_board_modified
	
    addiu $t0 $t0 1
    addiu $a0 $a0 2
    addiu $a1 $a1 2
	
	b e_loop
	
success:
	jr $ra

exit_board_modified:
    la $a0 error_message
	li $v0 4
	syscall
    li $v0 10
    syscall

# -- print_board_test --
# a0 : board (address of array of half words)
# a1 : size of the board (number of elements in the array a0)
# Behaviour:
# Print "Board Size: " followed by the size of the board.
# Print newline.
# Print "Board Content: " followed by the numbers from the
# sequence a0 separated by a space character
# Print newline.

print_board_test: 
	move	$t0 $a0

	la $a0 message_size
	li $v0 4
	syscall

	li	$v0 1
	
	# print size
	move $a0 $a1
	syscall		
	li	$v0 11	
	li	$a0 10 # '\n'
	syscall

	la $a0 message_content
	li $v0 4
	syscall
	
pr_loop: 
	beqz	$a1 pr_exit
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
	b	pr_loop
	
pr_exit:
	jr	$ra