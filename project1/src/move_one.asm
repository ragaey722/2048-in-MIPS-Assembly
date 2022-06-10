.text 
	.globl move_one
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|	
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	$v0 1 iff something changed else 0

move_one:
	li $v0 0
loop:
	lw    $t3 ($a0)
	lhu   $t0 ($t3)
	addiu $a1 $a1 -1
	addiu $a0 $a0 4
	blez  $a1 move_one_finished
	lw    $t4 ($a0)
	lhu   $t1 ($t4)
	beqz  $t0 check_and_move_one
	b     loop
	
check_and_move_one:
	beqz $t1 loop
	sh   $t1 ($t3)
	sh   $zero ($t4)
	li   $v0 1
	b    loop
		
move_one_finished:
	jr $ra
