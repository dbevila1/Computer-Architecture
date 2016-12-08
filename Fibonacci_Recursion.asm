#Daniel Bevilacqua
		  .data
prompt1:  .asciiz "This is Daniel Bevilacqua's Fibonacci calculator.\n"
prompt2:  .asciiz "Enter which Fibonacci term to calculate: "
 
		  .text
          .globl main
main:   
        la      $a0, prompt1    # system call to print prompt1 
        li      $v0, 4                 
        syscall         

        la      $a0, prompt2      # system call to print prompt2 (request Fib term) 
        li      $v0, 4                 
        syscall         

        li      $v0, 5          # system call to read an integer (the users input)
        syscall

# Steps:
# 1. call the fibonacci function
# 2. put the returned value into the appropriate return register ($v0)
# 3. add the statements to print out the result in the main function

	add $a0, $zero, $v0
	jal fibonacci
	
	add $a0, $zero, $v0
	li $v0, 1
	syscall
# system call to exit the program
        li $v0, 10
        syscall

fibonacci:  
	bge	$a0, 2, else	#check n < 2
	add	$v0, $zero, $a0
	jr	$ra
	
else:
	subi	$sp, $sp, 12	#make space for 3 on the stack
	sw	$ra, 0($sp)
	sw	$a0, 4($sp)
	subi	$a0, $a0, 1	#n = n-1
	jal fibonacci
	
	lw	$a0, 4($sp)	#load n from the stack
	sw	$v0, 8($sp)	#stores value fibonacci(n-1)
	subi	$a0, $a0, 2	#n = n-2
	jal fibonacci
	
	lw	$t0, 8($sp)	#$t0 = fibonacci(n-1)
	add	$v0, $t0, $v0	#add fibonacci(n-1) + fibonacci(n-2) 
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12	#remove space from stack
	jr $ra	
	

