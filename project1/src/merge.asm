.text
	.globl merge

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 

merge:
	li $v0 0 
	li $v1 0
loop:
	lw    $t3 ($a0)
	lhu   $t0 ($t3)
	addiu $a1 $a1 -1
	addiu $a0 $a0 4
	blez  $a1 merge_finished
	lw    $t4 ($a0)
	lhu   $t1 ($t4)
	beq   $t0 $t1 execute_merge
	b     loop

execute_merge:
	addiu $v0 $v0 1
	mulu  $t0 $t0 2
	addu  $v1 $v1 $t0
	sh    $t0 ($t3)
	sh    $0  ($t4)
	b     loop 

merge_finished:
    jr $ra
