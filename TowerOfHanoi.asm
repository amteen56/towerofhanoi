.data
Prompt:.asciiz "\nPlease enter the number of disks: "
Author:.asciiz "Author: Aaron Foltz\n"
MoveAB:.asciiz "Move disk from A to B\n"
MoveAC::.asciiz "Move disk from A to C\n"
MoveBC:.asciiz "Move disk from B to C\n"
MoveBA:.asciiz "Move from disk B to A\n"
MoveCB:.asciiz "Move from disk C to B\n"
MoveCA::.asciiz "Move from disk C to A\n"
Exit:.asciiz "The disks have all been moved"

    .text
main:
    li $v0, 4 
    la $a0, Author
    syscall
    
start:
    
    li  $v0, 4
    la  $a0, Prompt
    syscall

    li $v0, 5
    syscall
    add $t0, $v0, $zero 
    
    move $a0, $zero	
    move $a1, $zero	
    move $a2, $zero
    move $a3, $zero	
    
    move $a0, $t0	
    addi $a1, $a1, 1	
    addi $a2, $a2, 2
    addi $a3, $a3, 3
   
    addi $t3, $zero, 1	
    addi $t4, $zero, 2	
    addi $t5, $zero, 3	
    jal hanoi		
    li 	$v0, 4;      
    la 	$a0, Exit;    			
    syscall;
