.data 
#all variables that take place in program

prompt: 	.asciiz "Enter some text: "
string: 	.space 100
length:		.word 100
wordCount:	.word 0
charCount:	.word 0
words:		.asciiz " words "
characters: 	.asciiz " characters\n"
end:		.asciiz ""
newLine:	.asciiz "\n"
goodbye:	.asciiz "The program has terminated. Goodbye!"

.text
Main:
	#Outputs the prompt and waits for user to input string is dialog box (syscall #54)
	la $a0, prompt
	la $a1, string
	lw $a2, length
	li $v0, 54
	syscall
	
	#If the user inputs nothing or cancels the dialog box, the program then goes to function n
	beq $a1, -2, End
	beq $a1, -3, End
	
	#assigns string and length to $a0 & $a1 respectively
	la $a0, string
	lw $a1, length
	
	#creates a stack and passes the string into it
	addi $sp, $sp, -4
	sw $s1, 0($sp)
	la $s1, ($a0) 
	li $t1, 0
	li $t2, 1
	jal Loop2
	
	#stores the character amount and the word amount is $v0 and $v1 respectively
	sw $v0, charCount
	sw $v1, wordCount
	
	#outputs the string the user inputted
	la $a0, string 
	li $v0, 4
	syscall
	
	#outputs the word amount of the string
	lw $a0, wordCount
	li $v0, 1
	syscall
	
	#outputs 'words'
	la $a0, words
	li $v0, 4
	syscall
	
	#outputs the character amount of the string
	lw $a0, charCount
	li $v0, 1
	syscall
	
	#outputs 'characters'
	la $a0, characters
	li $v0, 4
	syscall
	
	#outputs a new line to help differentiate between the different strings the user inputs
	la $a0, newLine
	li $v0, 4
	syscall
	
	#loops back to the beginning of 'Main'
	j Main
	
End:
	#outputs 'goodbye!' in a dialog box (syscall #59)
	la $a0, end
	la $a1, goodbye
	li $v0, 59
	syscall
	li $v0, 10
	syscall
	
Loop2:
	#the byte address of $s1 is stored in $t4
	lb $t4, ($s1)
	
	#deletes stack when program reaches the end of string
	beq $t4, '\n', StackDeletion
	
	#increments character amount
	addi $t1, $t1, 1
	
	#increments word amount everytime a space occurs
	bne $t4, ' ', Word
	addi $t2, $t2, 1
	addi $s1, $s1, 1
	
	#loops back to the beginning
	j Loop2
	
StackDeletion:
	#deletes the stack with string
	lw $s1, 0($sp)
	add $sp, $sp, 4
	la $v0, ($t1)
	la $v1, ($t2)
	jr $ra
Word:
	#this happenes everytime a space occurs
	add $t2, $t2, $zero
	addi $s1, $s1, 1
	j Loop2
	

	

	
