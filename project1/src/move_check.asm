.text
	.globl move_check
#
#	$a0 buffer address
#	$a1 buffer length
#
#   $v0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
        lw    $t3 ($a0)
	lhu   $t0 ($t3)
	addiu $a1 $a1 -1
	addiu $a0 $a0 4
	blez  $a1 no_possible_move
	lw    $t3 ($a0)
	lhu   $t1 ($t3)
	beqz  $t0 pre_possible_move
	beq   $t0 $t1 possible_move_true
	b     move_check
	
no_possible_move:	
	li $v0 0
	jr $ra
pre_possible_move:
beqz $t1 move_check
	
possible_move_true:
	li $v0 1
	jr $ra