	.text
	.globl main
main:   
	la $a0, readN
	li $v0,4 #shows the first message in console
	syscall
	
	li $v0,5 #puts the input in $v0
	syscall
	
	move $s0,$v0 #puts the input in $s0
	
	la $a0, readK # shows the secons message
	li $v0,4
	syscall
	
	li $v0,5 #puts the input in $v0
	syscall
	
	move $s1,$v0 #puts the input in $s1
	
	move $a0,$s0 #puts n in argument
	move $a1,$s1 #puts k in argument
	
	
	jal Combinations
	move $s2,$v0  #put $v0 in $s2
	la $a0,print1
	li $v0,4
	syscall
	
	move $a0,$s0
	li $v0,1
	syscall
	
	la $a0,print2
	li $v0,4
	syscall
	
	move $a0,$s1
	li $v0,1
	syscall
	
	la $a0,print3
	li $v0,4
	syscall
	
	move $a0,$s2
	li $v0,1
	syscall
	
	li $v0, 10
	syscall
	

	
	
Combinations: 
	addi $t0, $zero,1 # i=1
	addi $t1, $zero,1 #factorial_n=1
Loop:
	bgt $t0,$a0,Combinations1 #if i>n go to Combinations2
	mul $t1,$t1,$t0 #factorial_n*=i
	addi $t0,$t0,1 #i++
	j Loop
	
Combinations1:
	addi $t2, $zero,1 # factorial_k=1
	addi $t0,$zero,1 # i=1
Loop1:	
	bgt $t0,$a1, Combinations2
	mul $t2,$t2,$t0 # factorial_k*=i
	addi $t0,$t0,1
	j Loop1
	
Combinations2:
	addi $t3,$zero,1 #factorial_n_k
	addi $t0,$zero,1 #i=1
	sub $t6,$a0,$a1
Loop2:
	bgt $t0,$t6, Combinations3
	mul $t3,$t3,$t0 #factorial_N_k*=i
	addi $t0,$t0,1
	j Loop2
Combinations3:
	mul $t4,$t2,$t3
	div $t5,$t1,$t4
	move $v0,$t5
	jr $ra
	
	

.data
readN : .asciiz "Enter number of objects in the set (n) : "
readK: .asciiz "Enter number to be chosen (k) : "
print1: .asciiz "C( "
print2: .asciiz " ,"
print3: .asciiz ") = "
CRLF: .asciiz "\n"
