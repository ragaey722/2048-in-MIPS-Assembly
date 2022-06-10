.data
    .globl init
    .globl move_gen
    .globl check_gen
#
# all functions in this file are called in the main
# 
    
bu:
    .word 0
bo:
    .word 0
offsets:
    .byte 0,0
    
.text
init:
#a0 buffer address
#a1 board
    sw $a0 bu
    sw $a1 bo
    jr $ra
    
move_gen:
#a0 inital offset
#a1 step offset
#a2 jump offset
    lw $s1 bu
    lw $s2 bo
    sb $a1 offsets
    la $t0 offsets
    sb $a2 1($t0) 
    addu $s7 $s2 $a0
    
    li $s5 0
    li $s6 0
    li $s4 0

l:
    lb $a1 offsets
    
    sw $s7 ($s1)
    addu  $s7 $s7 $a1
    sw $s7 4($s1)
    addu  $s7 $s7 $a1
    sw $s7 8($s1)
    addu  $s7 $s7 $a1
    sw $s7 12($s1)
        
##################    
    addiu $sp $sp -4
    sw $ra ($sp)
    
    la $a0 bu
    lw $a0 ($a0)
    li $a1 4
    li $v0 0
    li $v1 0
    jal complete_move
    addu $s6 $s6 $v0
    addu $s4 $s4 $v1
    
    lw $ra ($sp)
    addiu $sp $sp 4
##################
    la $t0 offsets    
    lb $a2 1($t0)
    
    addu $s7 $s7 $a2
    addiu $s5 $s5 1
    ble $s5 3 l

    beqz $s6 end
    addiu $s6 $s6 -1
    li $t0 1
    sllv $s6 $t0 $s6
    mul $s6 $s6 $s4
    
end:
    move $v0 $s6
    jr $ra
    
check_gen:
#a0 inital offset
#a1 step offset
#a2 jump offset
    lw $s1 bu
    lw $s2 bo
    sb $a1 offsets
    la $t0 offsets
    sb $a2 1($t0) 
    addu $s7 $s2 $a0

    li $v0 0
    li $s5 0
c:    
    lb $a1 offsets    
    bgt $s5 3 check_end

    sw $s7 ($s1)
    addu  $s7 $s7 $a1
    sw $s7 4($s1)
    addu  $s7 $s7 $a1
    sw $s7 8($s1)
    addu  $s7 $s7 $a1
    sw $s7 12($s1)            
                
##################    
    addiu $sp $sp -4
    sw $ra ($sp)
    
    la $a0 bu
    lw $a0 ($a0)
    li $a1 4
    jal move_check
    
    lw $ra ($sp)
    addiu $sp $sp 4
##################
    bnez $v0 check_end
                
    la $t0 offsets    
    lb $a2 1($t0)                            
    
    addu $s7 $s7 $a2
    addiu $s5 $s5 1
    b c
    
check_end:
    jr $ra    
    
