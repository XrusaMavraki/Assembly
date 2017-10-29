.text
.globl main


#Χρυσάνθη Μαυράκη p3130128
#Μεϊντάνης Δημήτρης p3130130
main:
	
	la $a0,comment
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t9, $v0
	beqz $t9,exit
	beq $t9,1,readPin1
	beq $t9,2,readPin2
	beq $t9,3, createSparse1
	beq $t9,4,createSparse2
	beq $t9,5,addSparceArrays
	beq $t9,6,DisplayS1
	beq $t9,7,DisplayS2
	beq $t9,8,DisplayAB
	

readPin1:
	lw $t7,length #put length in  $t7
	li $t6,0 #metritis
	la $t0,pinA
	j readPin
readPin2:
	lw $t7,length #put length in  $t7
	li $t6,0 #metritis
	la $t0,pinB
	j readPin
	
readPin:
	
	bge $t6,$t7,donemsg #if i>=pin.lentgh go to donemsg
	la $a0,comment1
	li $v0,4
	syscall
	move $a0, $t6
	li $v0,1
	syscall
	la $a0, comment2
	li $v0,4
	syscall
	li $v0,5
	syscall
	
	sw $v0, 0($t0)
	
	
	
	
	
	addi $t0, $t0, 4
	addi $t6, $t6, 1
	j readPin
	
createSparse1:

	li $t8,0 #metritis tou sparse
	li $t6, -1
	lw $t7,length #put length in  $t7
	la $t0,pinA
	la $t2,SparseA
	addi $t0, $t0, -4

	
	jal createSparse
	sw $t8, realength
	j donemsg
	
	
createSparse2:


	li $t8,0 #metritis tou sparse
	li $t6, -1
	lw $t7,length #put length in  $t7
	la $t0,pinB

	la $t2,SparseB

	addi $t0, $t0, -4
	jal createSparse
	sw $t8, realength2
	j donemsg
	
doneCreating: 
jr $ra


createSparse :
	addi $t6,$t6,1
	addi $t0,$t0,4
	bge $t6,$t7,doneCreating
	
	
	lw $t1,($t0)
	beqz $t1,createSparse
	sw $t6,($t2)
	sw $t1,4($t2)
	
	
	
	addi $t2,$t2,8
	addi $t8,$t8,2
	j createSparse
	
	
addSparceArrays:


	lw $t7,realength #put length in  $t7
	lw $t8,realength2
	add $t7,$t7,$t8
	
	sw $t7,realength3
	lw $t7,realength
	la $t0,SparseA
	lw $t1,($t0) #sto t1 to pinB[0]
	la $t2,SparseB
	lw $t3,($t2)
	la $t4,AddAB
	li $t5,0 #metritis tou sparceA
	li $t9,0 #metritis tou sparceB
	
	
	
	j AddArrays
AddArrays: 
	

	bge $t5,$t7, addBrest
	bge $t9,$t8, addArest
	beq $t1,$t3, addthem
	blt $t1,$t3 addA
	blt $t3,$t1 addB
	
	
addArest:
	
	sw $t1,($t4)
	lw $t1,4($t0)
	sw $t1, 4($t4)
	addi $t4,$t4,8
	addi $t5,$t5,2
	addi $t0,$t0,8
	lw $t1,($t0)
	
	
	
	bge $t5,$t7,donemsg
	j addArest
addBrest:
	
	sw $t3,($t4)
	lw $t3,4($t2)
	sw $t3,4($t4)
	addi $t4,$t4,8
	addi $t9,$t9,2
	addi $t2,$t2,8
	lw $t3,($t2)
	
	
	bge $t9,$t8,donemsg
	j addBrest	
addA:
	sw $t1,($t4)
	lw $t1,4($t0)
	sw $t1, 4($t4)
	addi $t4,$t4,8
	addi $t5,$t5,2
	addi $t0,$t0,8
	lw $t1,($t0)
	j AddArrays

addB:
	sw $t3,($t4)
	lw $t3,4($t2)
	sw $t3,4($t4)
	addi $t4,$t4,8
	addi $t9,$t9,2
	addi $t2,$t2,8
	lw $t3,($t2)
	j AddArrays

addthem: 
	add $t1,$t1,$t3
	sw $t5,($t4)
	sw $t1,4($t4)
	addi $t4,$t4,8
	addi $t2,$t2,4
	addi $t0,$t0,4
	addi $t5,$t5,2
	addi $t9,$t9,2
	lw $t1,($t0)
	lw $t3,($t2)
	j AddArrays

DisplayS1:
	
	lw $t7,realength #put length in  $t7
	la $t0,SparseA
	lw $t1,($t0) #sto t1 to pinA[0]
	li $t6,0
	j Display
	
DisplayS2:
	
	
	lw $t7,realength2 #put length in  $t7
	la $t0,SparseB
	lw $t1,($t0) #sto t1 to pinB[0]
	li $t6,0
	j Display
DisplayAB:
	lw $t7,realength3 #put length in  $t7
	la $t0,AddAB
	lw $t1,($t0) #sto t1 to pinB[0]
	li $t6,0
	j Display
	
Display: 
	bge $t6,$t7,donemsg #if i>=pin.lentgh go to donemsg
	move $a0, $t1
	
	li $v0,1
	syscall
	la $a0,space
	li $v0,4
	syscall
	addi $t6,$t6,1
	addi $t0,$t0,4
	lw $t1,($t0)
	j Display

exit: 
	li $v0,10
	syscall
	
donemsg: 
	li $t6,0 #metritis
	li $t7,0 
	la $a0,done
	li $v0,4
	syscall	
	j main
	


.data
space : .asciiz " "
CRLF : .adciiz "\n"
comment: .asciiz "What do you want to do?"
comment1:  .asciiz "Position "
comment2: .asciiz  " : "
done: .asciiz "Done. "
pinA : .word  0,0,0,0,0,0,0,0,0
pinB: .word 0,0,0,0,0,0,0,0,0

SparceA: .word 0,0,0,0,0,0,0,0,0
SparceB: .word 0,0,0,0,0,0,0,0,0 #bazo 10 stoixia gia na piaso mia xiroteri periptosi opou ta misa stoixia tou pinaka tha einai mi midenika
AddAB: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #bazo 20 stoixia os athrisma ton duo parapano 2 xiriston periptoseon

length: .word 10
realength: .word 0
realength2: .word 0
realength3: .word 0
