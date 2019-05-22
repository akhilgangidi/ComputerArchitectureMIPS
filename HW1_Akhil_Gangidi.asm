.data	
a: 		.space 4
b: 		.space 4
c: 		.space 4
out1:		.space 4
out2:		.space 4
out3:		.space 4
name:		.space 20
prompt1:	.asciiz "What is your name?: " 			  #prompt asking name of user
prompt2:	.asciiz "Please enter an integer between 1-100: " #prompt asking user to enter an integer
prompt3:	.asciiz "Your answers are: " 			  #prompt to show the answers

.text
main:
	#outputs prompt1 which is defined in .data
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#waits for user to input string and puts it into name variable
	li $v0, 8
	la $a0, name
	li $a1, 20
	syscall
	
	#outputs prompt2 which is defined in .data
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#waits for user to input value and puts it into variable a
	li $v0, 5
	syscall
	sw $v0, a
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#waits for user to input value and puts it into variable b
	li $v0, 5
	syscall
	sw $v0, b
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#waits for user to input value and puts it into variable c
	li $v0, 5
	syscall
	sw $v0, c
	
	#loads the value of a, b, and c in registers $t0, $t1, $t2
	lw $t0, a
	lw $t1, b
	lw $t2, c
	
	#calculates a+b+c and stores result in out1
	add $t3, $t0, $t1
	add $t3, $t3, $t2
	sw $t3, out1
	
	#calculates b+c-a and stores result in out2
	add $t3, $t1, $t2 
	sub $t3, $t3, $t0 
	sw $t3, out2 
	
	#calculates (a+2)+(b-5)-(c–1) and stores result in out3
	add $t3, $t0, 2
	sub $t4, $t1, 5
	sub $t5, $t2, 1
	add $t6, $t3, $t4
	sub $t7, $t6, $t5
	sw $t7, out3
	
	#displays name variable
	li $v0, 4
	la $a0, name
	syscall
	
	#displays prompt3
	li $v0, 4
	la $a0, prompt3
	syscall
	
	#displays out1
	li $v0, 1
	lw $a0, out1
	syscall

	#displays a space
	li $a0, 32
	li $v0, 11  
	syscall
	
	#displays out2
	li $v0, 1
	lw $a0, out2
	syscall
	
	#displays a space
	li $a0, 32
	li $v0, 11  
	syscall
	
	#displays out3
	li $v0, 1
	lw $a0, out3
	syscall
	
	#######################
	#	 Test	      #
	#	a = 7	      #
	#	b = 17        #
	#	c = 27        #
	#		      #
	#	 Result       #
	#	51 37 -5      #
	#######################
	