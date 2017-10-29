#OM-12#
#######
# KASSARI ANASTASIA - 3130088
# KROKOS CHRISTOS - 3130107
# MAVRAKI CHRYSANTHI TSAMPIKA - 3130128


				.text

##Variables##		
#a0 = base address of array		
#a1 = size of array
#s1 = index i of outer for loop
#s2 = index j of inner for loop
#s3 = size - i


		
main:	
				la $a0, array				#a0 = base address of array
				lw $a1, size				#a1 = size
				
				move $s1, $zero				#s1 = i = 0
				
for1:			
				slt $t0, $s1, $a1			#t0 = 0 if i >= n || t0 = 1 if i < n
				beq $t0, $zero, exit1		#go to exit1 if i >= n
				
				move $s2, $zero				#s2 = j = 0
				sub $s3, $a1, $s1			#s3 = size - i
				
for2:
				slt $t0, $s2, $s3 			#t0 = 0 if j >= size - i || t0 = 1 if j < size - i
				beq $t0, $zero, exit2		#go to exit2 if j >= size - i
				
				sll $t0, $s2, 2				#t0 = 4j
				add $t0, $a0, $t0			#t0 = address of array[j]
				
				lw $t1, 0($t0)				#t1 = array[j]
				lw $t2, 4($t0)				#t2 = array[j+1]
				
				slt $t3, $t2, $t1			#t3 = 0 if array[j+1] >= array[j] || t3 = 1 if array[j+1] < array[j]
				beq $t3, $zero, next		#go to next if array[j+1] >= array[j]
				
				sw $t2, 0($t0)				#new array[j] = t2 = array[j+1]
				sw $t1, 4($t0)				#new array[j+1] = t1 = array[j]

				
next:				
				addi $s2, $s2, 1 			#j++
				j for2
				
exit2:			
				
				addi $s1, $s1, 1 			#i++
				j for1
exit1:				
				
				jal printarray				
				
				li $v0, 10					#exit
				syscall
			

##Methods##
	
##Printing array method##
			
printarray:		
				la $t0, array				#s0 = address of array
				lw $t1,	size				#a1 = size
				move $t2, $zero				#i = 0
prloop:
				slt $t3, $t2, $t1			#t3 = 0  if i >= size || t3 = 1 if i < size
				beq $t3, $zero, exitpr		#go to exitpr if i >= size
				
				la $a0, printPos			#printing
				li $v0, 4					#Position: 
				syscall						#on screen
				
				sll $t3, $t2, 2				#t3 = 4*i
				add $t3, $t3, $t0			#t3 = address of array[i]
				
				addi $t2, $t2, 1			#i++
				
				move $a0, $t2				#printing
				li $v0, 1					#i
				syscall						#on screen
				
				la $a0, printVal			#printing
				li $v0, 4					# Value :
				syscall						#on screen
				
				lw $a0, 0($t3)				#printing
				li $v0, 1					#array[i]
				syscall						#on screen
				
				la $a0, CTRLF				#printing 
				li $v0, 4					#a new line
				syscall						#on screen
				
				j prloop
				
exitpr:					
				jr $ra						#return
				
				
				
				
				
				
				.data
				
size:			.word 20
array: 			.word 1, 2, 3, 9, 8, 6, 7, 5, 4, 0, 11, 25, 26, 86, 47, 4, 9, 36, 19, 100
printPos:		.asciiz "Position : "
printVal:		.asciiz " Value : "
CTRLF:			.asciiz "\n"