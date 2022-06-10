.text
	.globl check_victory


#
#	$a0 board address
#	$a1 board length
#
#	$v0 == 1 iff 2048 found
#

check_victory:
	li $v0 0
	lhu $t0 0($a0)
	beq $t0 2048 end_victory
	addiu $a1 $a1 -1
	addiu $a0 $a0 2
	bgtz  $a1 check_victory 
    
	jr $ra
end_victory:

	li $v0 1
	jr $ra