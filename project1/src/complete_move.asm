.text
	.globl complete_move
	

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 


complete_move:

        addiu $sp $sp -20
        sw $ra 0($sp)
	sw $a0 4($sp)
	sw $a1 8($sp)
	jal move_left
	lw $a0 4($sp)
	lw $a1 8($sp)
	jal merge
	sw $v0 12($sp)
	sw $v1 16($sp)
	lw $a0 4($sp)
	lw $a1 8($sp)
	jal move_left
	lw $ra 0($sp)
	lw $a0 4($sp)
	lw $a1 8($sp)
	lw $v0 12($sp)
	lw $v1 16($sp)
	addiu $sp $sp 20


    jr $ra
