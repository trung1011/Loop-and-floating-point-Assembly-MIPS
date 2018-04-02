.data
	# 
	message: .asciiz "Enter an integer that is greater than 0: "
	message2: .asciiz "The result is "
	message3: .asciiz "Program finished successful."
	message4: .asciiz "Wrong input, please run the program again and read the message carefully."
	newline: .asciiz "\n"
	oneDouble: .double 1.0
.text
	main: 
	#Print the string (message) from data to the screen
	li $v0, 4		#Tell the system to prepare to print out the string (message)
	la $a0, message		#Load the string (message) from data to $a0
	syscall			
	
	#Get input value from keyboard
	li $v0, 5	#The input value will be stored in $v0
	syscall
	
	#Move the input value from $v0 to $t0
	move $t0, $v0
	
	#If the value in $t0 is less or equal to 0, do the "wrongInput" procedure below
	blez $t0, wrongInput
	
	#Change the value type: integer in $t0 to double in $f2
	mtc1.d $t0, $f2
	cvt.d.w $f2, $f2
	
	#Load the value (oneDouble: 1.0) from data to $f4
	ldc1 $f4, oneDouble
	
	#Loop
		while:
			c.eq.d $f14, $f2		#Compare $f14 with $f2 if they are equal or not
			bc1t exit			#if they are equal go to "exit" below
			add.d $f14, $f14, $f4		#Add the value in $f14 with the value in $f4 (1.0) and store in $f14 
			add.d $f16, $f14, $f4		#Add the value in $f14 with the value in $f4 (1.0) and store in $f16 
			div.d $f18, $f14, $f16		#Divide the value in $f14 to the value in $f16 and store in $f18 
			add.d $f10, $f10, $f18		#Add the value in $f10 with the value in $f18 and store in $f10 
			
			
			j while				#Jump back to "while" (Create the loop)
		exit:
			#print a newline to screen
			li $v0, 4			
			la $a0, newline
			syscall
			#print the string (message2) from data to screen
			li $v0, 4
			la $a0, message2
			syscall
			#print the result stored in $f10 to screen
			li $v0, 3		#Tell the system to prepare to print out a double value
			mov.d $f12, $f10	#Move the result value in $f10 to $f12
			syscall
			#print a newline to screen
			li $v0, 4
			la $a0, newline
			syscall
			#print the string (message3) from data to screen
			li $v0, 4
			la $a0, message3
			syscall
			
	#End main
	li $v0, 10
	syscall
	
	#wrongInput procedure
	wrongInput:
	#Print out the string (message4) from data to screen
	li $v0, 4		
	la $a0, message4	
	syscall
	li $v0, 10		#End the procedure
	syscall
	
	#Information in Co-processor 1 while the system is running:
	#f4: 1.0
	#f2: n
	#f14: i
	#f16: i+1
	#f18: i/i+1
	#f10: result
