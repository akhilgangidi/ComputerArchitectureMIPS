.data 	#data that is used throughout the program
name: 		.space 20
bmi1:		.float 18.5
bmi2:		.float 25
bmi3:		.float 30
namePrompt:	.asciiz "What is your name? "
heightPrompt: 	.asciiz "Please enter your height in inches: "
weightPrompt: 	.asciiz "Now enter your weight in pounds (round to a whole number): "
bmiMsg: 	.asciiz ", your bmi is: "
underWeight: 	.asciiz "\nThis is considered underweight.\n"
normalWeight: 	.asciiz "\nThis is a normal weight.\n"
overWeight:	.asciiz "\nThis is considered overweight.\n"
obeseWeight:	.asciiz "\nThis is considered obese.\n"

.text
Main:
	#Asks the user what the user's name is
	li $v0, 4
	la $a0, namePrompt
	syscall
	
	#waits until the user inputs the name
	li $v0, 8 
	la $a1, 20
	la $a0, name
	syscall
	
	#sets index to 0
	li $s0,0        
remove: #iterates through the array of characters until \n is found and replaces it with 0
    	lb $a3, name($s0)   
    	addi $s0, $s0, 1      
	bnez $a3, remove     
   	beq $a1, $s0, skip    
    	subiu $s0, $s0, 2     
    	sb $0, name($s0)    

skip:
	#asks the user for his height
	la $a0, heightPrompt
	li $v0, 4
	syscall
	
	#waits till the user inputs height in inches and stores it in $s0 from $v0 
	li $v0, 5
	syscall
	la $s0, ($v0)
	
	#asks the user for his weight
	la $a0, weightPrompt 
	li $v0, 4
	syscall
	
	#waits until the user inputs weight and stores it from $s1 from $v0
	li $v0, 5
	syscall
	la $s1, ($v0)
	
	mul $s1, $s1, 703 #multiplies weight by 703
	mul $s0, $s0, $s0 #mulitplies height by itself
	 
	mtc1 $s0, $f2 #moves it to a float register
	cvt.s.w $f0, $f2 #converts input from word to float
	
	mtc1 $s1, $f0 #moves it to a float register
	cvt.s.w $f1, $f0 #converts input from word to float
	
	div.s $f4, $f0, $f2 #divides weight*703 by height^2
	
	#outputs the user's name
	la $a0, name
	li $v0, 4
	syscall
	
	#displays the bmiMsg definied in .data
	la $a0, bmiMsg
	li $v0, 4
	syscall
	
	#prints the BMI
	li $v0, 2
 	mov.s $f12, $f4
 	syscall
	
	#if bmi is less than 18.5 is goes to UnderW method
	l.s $f2, bmi1
	c.lt.d $f4, $f2
	bc1t UnderW
	
	#if bmi is less than 25 is goes to NormalW method
	l.s $f2, bmi2
	c.lt.d $f4, $f2
	bc1t NormalW
	
	#if bmi is less than 30 is goes to OverW method
	l.s $f2, bmi3
	c.lt.d $f4, $f2
	bc1t OverW
	
	j ObeseW #if bmi is more than 30 it goes to ObeseW method 
	
UnderW:  #displays that person is underweight
	li $v0, 4
	la $a0, underWeight
	syscall
	
	j Exit #jumps to exit method
	
NormalW: #displays that person is of noraml weight
	li $v0, 4
	la $a0, normalWeight
	syscall #jumps to exit method
	
	j Exit
OverW:   #displays that person is overweight
	li $v0, 4
	la $a0, overWeight
	syscall
	
	j Exit #jumps to exit method
ObeseW:  #displays that person is obese
	li $v0, 4
	la $a0, obeseWeight
	syscall
	
	j Exit #jumps to exit method
Exit:    #ends program
	li $v0, 1
	syscall