.data
    .globl main
board:
    .half 20,0,0,0
    .half 0,2048,0,0
    .half 0,0,200,0
    .half 0,0,0,10


.text
main:
    la $a0 board
    li $a1 4
    li $a2 4

    jal printboard

    li $v0 10
    syscall
