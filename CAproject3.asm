 #Daniel Bevilacqua
 #Project 3 floating point average calculator
 #11/29/2016
 
 .data
prompt1:  .asciiz "Daniel Bevilacqua's Floating Point Average Calculator \n"
prompt2:  .asciiz "How many numbers would you like to average? "
prompt3:  .asciiz "Please enter a 3 digit decimal d.dd: "
prompt4:   .asciiz "The average is: "

newline:  .asciiz "\n"
				.text
          .globl main
main:   
        la      $a0, prompt1    # prints prompt1 
        li      $v0, 4                 
        syscall         

        la      $a0, prompt2    # prints prompt2  
        li      $v0, 4                 
        syscall         

        li      $v0, 5          # reads in an integer (number of floats to average)
        syscall
        
        add $s0, $v0, $zero	# Stores number of floats
        
        mtc1 $v0, $f1		# puts user input, $v0 into $f1
        cvt.s.w $f1, $f1	# Convert from integer into single precision float point
        
        jal dataCollect
        
        jal averageLoop

	# system call to exit the program
        li $v0, 10
        syscall

dataCollect:
	bge $t0, $s0, exit
	
	la      $a0, prompt3	# prints prompt3 
        li      $v0, 4                 
        syscall         
        
        li      $v0, 6         	# read the float the user input
        syscall
	
	add.s $f2, $f2, $f0	# adds float inputs
	addi $t0, $t0, 1
	j dataCollect
exit:
	jr $ra
averageLoop:
	div.s $f3, $f2, $f1
	
	la      $a0, newline    # prints an endl for beauty
        li      $v0, 4 
        la      $a0, prompt4    # prints the average prompt for user understanding  
        li      $v0, 4                    
        syscall   
            
  	mov.s $f12, $f3   	# loads the final answer to be displayed
  	li $v0, 2
  	syscall
  	
  	jr $ra
	
