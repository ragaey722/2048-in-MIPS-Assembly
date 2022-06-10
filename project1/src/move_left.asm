.text
	.globl move_left
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|	
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|	
#
	
move_left:

        li $v0 0
        addiu $sp $sp -12
        sw $ra 0($sp)
	sw $a0 4($sp)
	sw $a1 8($sp)
	jal move_one
	lw $ra 0($sp)
	lw $a0 4($sp)
	lw $a1 8($sp)
	addiu $sp $sp 12
	beq  $v0 1 move_left
	
    jr $ra
    
