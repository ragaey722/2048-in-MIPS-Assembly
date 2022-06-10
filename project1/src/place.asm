.text
	.globl place
	
# 	$a0 board address
# 	$a1 board length
#	$a2 field number to place into
#	$a3 number to place
#
#	$v0 == 0 iff place succesfull else 1
#

place:
	mulu $a2 $a2 2
	addu $a0 $a0 $a2
	lhu  $t0 ($a0)
	bgtz $t0 not_empty
	sh $a3 ($a0)
	li $v0 0
	jr $ra
not_empty:
	li $v0 1	
	jr $ra	
	
	
	
