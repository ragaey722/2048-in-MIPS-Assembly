.data

board:
    .half 0,0,0,0
    .half 0,0,0,0
    .half 0,0,0,0
    .half 0,0,0,0
        
buffer:
    .word 0,0,0,0   
score:
    .word 0
    
pretty_print:
    .byte 1
    
greeterstr:
    .asciiz "----- 2048 -----\n pretty print:\n"
    
newline:
    .asciiz "\n"
msgVictory1:
    .asciiz " Game ends with "
msgVictory2:
    .asciiz " points\n"

msgInvalid:
    .asciiz "Invalid Input, please try again\n> "
  
.text
    .globl main

.macro zeilenumbruch #"\n"
	la $a0 newline
	li $v0 4
	syscall
.end_macro

# main marks the programms entry point
main:
    li $a0 6400

    jal random_init
        
    li $v0 4
    la $a0 greeterstr
    syscall        #print greeting string 
    
    li $v0 5    # pretty print ?
    syscall
    sb $v0 pretty_print 
    
    la $a0 buffer
    la $a1 board
    jal init
    
      
    jal place_new
    jal place_new
    
    jal print_call
    
checkmove:
    la $a0 board
    li $a1 16
##################    
    addiu $sp $sp -4
    sw $ra ($sp)
    
    jal check_victory
    
    lw $ra ($sp)
    addiu $sp $sp 4
##################    
    beq $v0 1 win
    li $s1 0  
        
movepos:
    li $s0 4
    la $s1 buffer
    la $s2 board
    
    li $v0 12
    syscall                     #get keyboard input
    
    
    move $s4 $v0                #accepted moves are w a s d 
    li $v0 4                    # input q to quit game
    la $a0 newline
    syscall
    li $s6 1
    
    
    li $s3 'w'
    beq $s3 $s4 w
        
    li $s3 'a'
    beq $s3 $s4 a    

    li $s3 's'
    beq $s3 $s4 s
    
    li $s3 'd'
    beq $s3 $s4 d
    
    li $s3 'q'
    beq $s3 $s4 win
    
    li $v0 4
    la $a0 msgInvalid
    syscall
    b movepos
    
w:
    li $a0 0
    li $a1 8
    li $a2 -22
    jal check_gen
    
    bne $v0 1 invalid

    li $a0 0
    li $a1 8
    li $a2 -22
    jal move_gen

    lw $t0 score
    addu $t0 $t0 $v0
    sw $t0 score
    
    b movedone
    
a:

    li $a0 0
    li $a1 2
    li $a2 2
    jal check_gen
    
    bne $v0 1 invalid

    li $a0 0
    li $a1 2
    li $a2 2
    jal move_gen

    lw $t0 score
    addu $t0 $t0 $v0
    sw $t0 score
    
    b movedone

    
s:

    li $a0 24
    li $a1 -8
    li $a2 26
    jal check_gen
        
    bne $v0 1 invalid

    li $a0 24
    li $a1 -8
    li $a2 26
    jal move_gen

    lw $t0 score
    addu $t0 $t0 $v0
    sw $t0 score
    
    b movedone

    
d:
    li $a0 6
    li $a1 -2
    li $a2 14
    jal check_gen
    
    bne $v0 1 invalid

    li $a0 6
    li $a1 -2
    li $a2 14
    jal move_gen

    lw $t0 score
    addu $t0 $t0 $v0
    sw $t0 score
    
    b movedone
            
movedone:
    jal place_new
    
invalid:    
    li $a0 24       #s
    li $a1 -8
    li $a2 26
    jal check_gen
    beq $v0 1 not_lost
    
    li $a0 6        #d
    li $a1 -2
    li $a2 14
    jal check_gen     
    beq $v0 1 not_lost
        
    li $a0 0        #a
    li $a1 2
    li $a2 2
    jal check_gen
    beq $v0 1 not_lost
    
    li $a0 0        #w
    li $a1 8
    li $a2 -22
    jal check_gen
    beq $v0 1 not_lost
    b lost
    
not_lost:
    # Print board after each turn
    jal print_call

    b checkmove
    
    
lost:    
win:
    li $v0 4
    la $a0 msgVictory1
    syscall    
    
    li $v0 1
    la $a0 score
    lw $a0 ($a0)
    syscall
    
    li $v0 4
    la $a0 msgVictory2
    syscall

    # Print final board
    jal print_call
    
    # end the programm with syscall 10 (only allowed for "main")
    li     $v0 10
    syscall




place_new:
##################    
    addiu $sp $sp -4
    sw $ra ($sp)
    
    jal random
    
    lw $ra ($sp)
    addiu $sp $sp 4
##################    
    rem $a0 $v0 10    
    li $t0 9            #test for rnd= 9 => place 4
    beq $t0 $a0 rnd4 
    li $a3 2#
    b cont
rnd4:
    li $a3 4#
cont:
##################    
    addiu $sp $sp -4
    sw $ra ($sp)
        
    jal random

    lw $ra ($sp)
    addiu $sp $sp 4
##################    
    rem $a0 $v0 16

tryagain:
    move $a2 $a0
    la $a0 board    
    li $a1 16
    
##################    
    addiu $sp $sp -4
    sw $ra ($sp)
    
    jal place
    
    lw $ra ($sp)
    addiu $sp $sp 4
##################    
    bnez $v0 cont
    jr $ra    
    
    
    
    
print_call:

##################    
    addiu $sp $sp -4
    sw $ra ($sp)
    
    la $a0 board
    li $a1 16
    lbu $t0 pretty_print
    beqz $t0 print_board_line_2
    jal printboard
    zeilenumbruch
    j end_print_2
print_board_line_2:
    lw $a2 score
    jal print_board_state_oneline
end_print_2:
    
    lw $ra ($sp)
    addiu $sp $sp 4
##################

    jr $ra
