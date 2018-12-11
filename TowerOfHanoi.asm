.data
Prompt:.asciiz "\nPlease enter the number of disks: "
MovAB:.asciiz "Move disk from A to B\n"
MovAC::.asciiz "Move disk from A to C\n"
MovBC:.asciiz "Move disk from B to C\n"
MovBA:.asciiz "Move from disk B to A\n"
MovCB:.asciiz "Move from disk C to B\n"
MovCA::.asciiz "Move from disk C to A\n"
Exit:.asciiz "Task Completed"

    .text
main:  
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
    jal hanoi1		
    li 	$v0, 4;      
    la 	$a0, Exit;    			
    syscall;
	
	.data
hanoi1:
	
	slti $t1, $a0, 1
	beq $t1, $t3, End	
	
	addi $sp, $sp, -20
	sw $ra, 0($sp)		
	sw $a0, 4($sp)		
	sw $a1, 8($sp)		
	sw $a2, 12($sp)		
	sw $a3, 16($sp)		
	
	addi $a0, $a0, -1		
	move $t2, $a2		
	move $a2, $a3		
	move $a3, $t2	
	
	jal hanoi		
	
	lw $ra, 0($sp)		
	lw $a0, 4($sp)		
	lw $a1, 8($sp)		
	lw $a2, 12($sp)		
	lw $a3, 16($sp)		
	add $sp, $sp, 20
		
	beq $a1, $t3, FromA	
	beq $a1, $t4, FromB	
	beq $a1, $t5, FromC	
	
hanoi2:

	addi $sp, $sp, -20
	sw $ra, 0($sp)		
	sw $a0, 4($sp)		
	sw $a1, 8($sp)		
	sw $a2, 12($sp)		
	sw $a3, 16($sp)		
	
	move $t6, $a1		
	move $t7, $a2		

	move $a1, $a2		
	move $a2, $t6		

	addi $a0, $a0, -1	
	jal hanoi1		
	
	lw $ra, 0($sp)		
	addi $sp, $sp, 20
	jr $ra
	
FromA:
	beq $a3, $t4, PAB	
	beq $a3, $t5, PAC	
	
PAB:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		
	li  $v0, 4 
	la  $a0, MovAB
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2

PAC:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		
	li  $v0, 4 
	la  $a0, MovAC
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
FromB:
	beq $a3, $t3, PBA	
	beq $a3, $t5, PBC	

PBA:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		
	li  $v0, 4 
	la  $a0, MovBA
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
PBC:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		
	li  $v0, 4 
	la  $a0, MovBC
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
FromC:
	beq $a3, $t3, PCA	
	beq $a3, $t4, PCB	
	
PCA:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		
	li  $v0, 4
	la  $a0, MovCA
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2

PCB:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		
	li  $v0, 4 
	la  $a0, MovCB
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
	
End:
	jr $ra