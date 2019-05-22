# Milan Patel	CS3340.005
	.data
	
name:			.space 20
string_space:		.space 1024
numSpot: 		.byte '1', '2', '3', '4', '5', '6', '7', '8', '9'
gameMsg: 		.asciiz " \n\n Tic Tac Toe\n"
playerMsg: 		.asciiz " Player 1 (X) - Player 2 (0) \n\n"
board1: 		.asciiz " | | \n"
board2:			.asciiz " "
board3: 		.asciiz " | "
board4: 		.asciiz "_____|_____|_____\n"
board5: 		.asciiz " \n"
numPromptP1: 		.asciiz "Player 1, enter a number : "
numPromptP2: 		.asciiz "Player 2, enter a number : "
errorMsg:		.asciiz "\nInvalid move. Try again : "
winner1: 		.asciiz "Player 1 wins.\n"
winner2: 		.asciiz "Player 2 wins.\n"
drawMsg: 		.asciiz "The game is a draw.\n"
palinMsg:		.asciiz "The string is a palindrome. \n"
notPalinMsg:  		.asciiz "The string is not a palindrome.\n"
palinPrompt: 		.asciiz "Enter a string to see if it is a palindrome: "
fibPrompt: 		.asciiz "Enter a non-negative number: "
fibResultMsg: 		.asciiz "The fibonacci result for given number: "
equalSign: 		.asciiz " = "
newLine:   		.asciiz "\n"
namePrompt: 		.asciiz "Enter your name: "
thankPrompt: 		.asciiz "Program will now end. Thank you, "

	.text
main:

     # Begin program by asking the user for their name and store
     la $a0, namePrompt
     li $v0, 4
     syscall

     li $v0, 8
     la $a1, 20
     la $a0, name
     syscall
     
     # Loading array named numSpot
     la $k0, numSpot              
     addi $s0, $zero, 1
     addi $s3, $zero, 88
     addi $s4, $zero, 79
     
start:

      # Calling function to print board
      jal Board                  
      lb $t0, 0($k0)
      lb $t1, 1($k0)
      lb $t2, 2($k0)
      lb $t3, 3($k0)
      lb $t4, 4($k0)
      lb $t5, 5($k0)
      lb $t6, 6($k0)
      lb $t7, 7($k0)
      lb $t8, 8($k0)
      beq $s0, 2, Player2
      
# When its player 1 turn
Player1:                         
       
       # Prompt user
       li $s0, 2
       la $a0, numPromptP1
       li $v0, 4
       syscall
       
       addi $s6, $zero, 88 
       j condition
 
# When its player 2 turn      
Player2:                        

       # Prompt user
       li $s0, 1
       la $a0, numPromptP2
       li $v0, 4
       syscall   
       li $s6, 79

# Test for tic tac toe
# Statements to check status of the games used for check1 - check10
condition:                      

         li $v0, 12
         syscall
              
         addi $a3, $v0, 0
         beq $a3, $s3, check9
         beq $a3, $s4, check9
         bne $a3, $t0, check1
         sb  $s6, 0($k0)
         j check10

check1:

         bne $a3, $t1, check2
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 1($k0)
         j check10

check2:

         bne $a3, $t2, check3
         beq $a3, $s6, check9
         sb  $s6, 2($k0)
         j check10

check3:

         bne $a3, $t3, check4
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 3($k0)
         j check10

check4:

         bne $a3, $t4, check5
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 4($k0)
         j check10

check5:

         bne $a3, $t5, check6
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 5($k0)
         j check10

check6:

         bne $a3, $t6, check7
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 6($k0)
         j check10

check7:

         bne $a3, $t7, check8
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 7($k0)
         j check10

check8:

         bne $a3, $t8, check9
         beq $a3, $s6, check9
         beq $a3, $s4, check9
         sb  $s6, 8($k0)
         j check10

# Check9 function display error message and jump back
check9:

         la  $a0, errorMsg
         addi $v0, $zero, 4
         syscall
         j condition

# Check10 function checks the status of the game called at the end of each condition
check10:

         jal CheckWin                     
         addi $k1, $v0, 0
         beq $k1, -1, start
         jal Board
         beq $k1, 0, gameDraw
         beq $s0, 1, player2Win

# Function displays if player 1 is the winner
player1Win:                                            

         la $a0 winner1
         addi $v0, $zero, 4
         syscall
         j palin

# Function to display if player 2 is the winner of the game
player2Win:                                    

         la $a0 winner2
         addi $v0, $zero, 4
         syscall
         j palin

# Function to display if the game ends in a draw
gameDraw:                                   

         la $a0, drawMsg
         addi $v0, $zero, 4
         syscall
         j palin     

# CheckWin function returns essentially 3 values
# The function will result in 0 if it is a draw
# It will result in -1 if the game is still in progress
# It will result in 1 if the game is over and has a result meaning winner
CheckWin:                                 

        lb $t0, 0($k0)                    
        lb $t1, 1($k0)                    
        lb $t2, 2($k0)                    
        lb $t3, 3($k0)
        lb $t4, 4($k0)
        lb $t5, 5($k0)
        lb $t6, 6($k0)
        lb $t7, 7($k0)
        lb $t8, 8($k0)
        bne $t0, $t1, secondCheck2
        bne $t1, $t2, secondCheck2
        li $v0, 1
        jr $ra

secondCheck2:

        bne $t3, $t4, secondCheck3
        bne $t4, $t5, secondCheck3
        li $v0, 1
        jr $ra

secondCheck3:

        bne $t6, $t7, secondCheck4
        bne $t7, $t8, secondCheck4
        li $v0, 1
        jr $ra

secondCheck4:

        bne $t0, $t3, secondCheck5
        bne $t3, $t6, secondCheck5
        li $v0, 1
        jr $ra

secondCheck5:

        bne $t1, $t4, secondCheck6
        bne $t4, $t7, secondCheck6
        li $v0, 1
        jr $ra

secondCheck6:

        bne $t2, $t5, secondCheck7
        bne $t5, $t8, secondCheck7
        li $v0, 1
        jr $ra

secondCheck7:

        bne $t0, $t4, secondCheck8
        bne $t4, $t8, secondCheck8
        li $v0, 1
        jr $ra

secondCheck8:

        bne $t2, $t4, secondCheck9
        bne $t4, $t6, secondCheck9
        li $v0, 1
        jr $ra

secondCheck9:

        beq $t0, '1', secondCheck10
        beq $t1, '2', secondCheck10
        beq $t2, '3', secondCheck10
        beq $t3, '4', secondCheck10
        beq $t4, '5', secondCheck10
        beq $t5, '6', secondCheck10
        beq $t6, '7', secondCheck10
        beq $t7, '8', secondCheck10
        beq $t8, '9', secondCheck10
        li $v0, 1
        jr $ra

secondCheck10:

        li $v0, -1
        jr $ra

# Board function displays the board
Board:                                

     lb $t0, 0($k0)
     lb $t1, 1($k0)
     lb $t2, 2($k0)
     lb $t3, 3($k0)
     lb $t4, 4($k0)
     lb $t5, 5($k0)
     lb $t6, 6($k0)
     lb $t7, 7($k0)
     lb $t8, 8($k0)
     la $a0, gameMsg
     li $v0, 4
     syscall

     la $a0, playerMsg
     syscall
     
     la $a0, board1
     syscall
     
     la $a0, board2
     syscall

B1:  

     addi $a0, $t0, 0
     li $v0, 11
     syscall
    
     la $a0, board3
     li $v0, 4
     syscall
     
B2:  

     addi $a0, $t1, 0
     li $v0, 11
     syscall
     
     la $a0, board3
     li $v0, 4
     syscall

B3:  

     addi $a0, $t2, 0
     li $v0, 11
     syscall

     la $a0, board5
     li $v0, 4
     syscall
     
     la $a0, board4
     syscall

     la $a0, board1
     syscall
     
     la $a0, board2
     syscall

B4:

     addi $a0, $t3, 0
     li $v0, 11
     syscall

     la $a0, board3
     li $v0, 4
     syscall

B5: 

     addi $a0, $t4, 0
     li $v0, 11
     syscall

     la $a0, board3
     li $v0, 4
     syscall

B6:

     addi $a0, $t5, 0
     li $v0, 11
     syscall

     la $a0, board5
     li $v0, 4
     syscall  

     la $a0, board4
     syscall

     la $a0, board1
     syscall

     la $a0, board2
     syscall

B7:

     addi $a0, $t6, 0
     li $v0, 11
     syscall
   
     la $a0, board3
     li $v0, 4
     syscall

B8:

     addi $a0, $t7, 0
     li $v0, 11
     syscall
     
     la $a0, board3
     li $v0, 4
     syscall

B9:

     addi $a0, $t8, 0
     li $v0, 11
     syscall

     la $a0, board5
     li $v0, 4
     syscall

     la $a0, board1
     syscall
     jr $ra

# Palindrome checker function
palin:

    # Prompt the user to enter string
    la $a0, palinPrompt     
    li $v0, 4                             
    syscall
    
    # Read user input for the given string
    # Create space and store string
    la $a0, string_space     
    li $a1, 1024                      
    li $v0, 8                           
    syscall

    # Load address into register $t1
    la $t1, string_space    
    la $t4, string_space    

# Loads the byte from address into given $t5 register
# Go to checkPali function until end of given string
length_loop:

        lb $t5, ($a0) 
        beq $t5, 10, checkPalindrome
        bgt $t5, 47, t1   
        b negative
   
t1: 
	# Less than 58 go to positive or greater than 64 go to t2
	blt $t5, 58, positive
        bgt $t5, 64, t2
        b negative
       
t2: 
	# Less than 91 go to positive or greater than 96 go to t3
	blt $t5, 91, positive 
        bgt $t5, 96, t3 
        b negative
        
t3: 
	# Less than 123 go to positive
	blt $t7, 123, positive
        b negative
       
# Deal with each character go to makeLow
positive: 

    	bgt $t5, 96, makeLow
        b notUp

# Ignore case meaning upper or lower case    
makeLow: 

	subi $t5, $t5, 32

notUp:
	
	# Increment memory location
        sb $t5, ($t1)
        addi $a0, $a0, 1 
        addi $t1, $t1, 1
        b length_loop

# Increment user input
negative: 

        addi $a0, $a0, 1
        b length_loop

# Process chars decrement from $t1 
checkPalindrome:

    sb $zero, ($a0)
    addi $t1, $t1, -1  

# Loop checks if strings are same starting from opposite ends
loop:         

    lb $t3, ($t4)
    lb $t2, ($t1)  
    # Continue to check if it finds that the bytes are equal
    beq $t3, $t2, next 
    b notPalindrome

next: 

    # Check to see if not at last bye
    jal loopTest 
    # Move registers closer to middle from both sides
    addi $t4, $t4, 1              
    addi $t1, $t1, -1            
    b loop   
    b notPalindrome

loopTest:

	# Test to determine if more chars need to be checked
        beq $t4, $t1, isPalindrome
        addi $t1, $t1, -1
        beq $t4, $t1, isPalindrome   
        addi $t1, $t1, 1    
        jr $ra          

# Print that it is palindrome and jump to fibonacci
isPalindrome:    

        la $a0, string_space
        li $v0, 4
        la $a0 palinMsg
        syscall
        j fibonacciStart

# Print the not palindrome message and jump to fibonacci
notPalindrome:

        la $a0, notPalinMsg 
        li $v0, 4
        syscall
        j fibonacciStart     
  
fibonacciStart:     

	# Prompt user for fibonacci number
 	la $a0, fibPrompt
 	li $v0, 4
 	syscall
   
   	# Read the number 
 	li $v0, 5    
 	syscall

 	move $t2,$v0  
 	# Function call to find fibonnacci for the number (n)
 	move $a0, $t2
	move $v0, $t2
	# Call function to calculate fibonacci number of given number
   	jal calculateFib     

	# Result stored into $t3
   	move $t3, $v0    
   	# Write output message followed by entered number
   	la $a0, fibResultMsg
   	li $v0, 4
   	syscall

  	move $a0, $t2  
   	li $v0, 1
   	syscall

   	la $a0, equalSign
   	li $v0, 4
   	syscall

	# Display result at the end of the statement
   	move $a0,$t3    
   	li $v0,1
   	syscall

   	la $a0, newLine
   	li $v0, 4
   	syscall
   	j programEnd
   
# Function to calculate fibonacci number using given input from user
calculateFib:
   	
   	# If n = 0 return 0 or if n = 1 return 1
   	beqz $a0,zero   
   	beq $a0,1,one   
   	# Call the calculate function with n-1 and store return address on stack
   	sub $sp,$sp,4   
   	sw $ra,0($sp)
  	sub $a0,$a0,1   
   	jal calculateFib     
   
   	# Restore return address
   	add $a0,$a0, 1
   	lw $ra, 0($sp)   
   	# Push return value to the stack
   	add $sp,$sp, 4
   	sub $sp,$sp, 4  
  	sw $v0, 0($sp)
   	# Call calculateFib with n-2
   	sub $sp,$sp, 4
   	sw $ra, 0($sp)
   	sub $a0,$a0, 2   
   	jal calculateFib     

   	add $a0,$a0, 2
   	lw $ra, 0($sp)
   	add $sp,$sp, 4
   	lw $s7, 0($sp)
   	add $sp,$sp, 4
   	# f(n-2)+fib(n-1)
   	add $v0,$v0, $s7 
   	jr $ra 

# If 0
zero:

   	li $v0, 0
   	jr $ra

# If 1
one:

   	li $v0, 1
   	jr $ra

# End program with thanking the user
programEnd:

   	la $a0, thankPrompt
   	li $v0, 4
   	syscall
   
   	la $a0, name
   	li $v0, 4
   	syscall

   	b exit

# Exit function used to end program
exit:                                  

         li $v0, 10
         syscall 
   

