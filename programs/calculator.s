# Single-digit claculator with no error handling
# Credit to Charlie Curtsinger for partial code.
.constant TERM      0xff10
.constant HALT      0xff00
.constant KBD       0xff20
.constant STACK_TOP 0xf800

nop
main:
  li   $s0, TERM                # Address of the terminal output for memory-mapped I/O
  li   $s1, KBD                 # Address of the keyboard input for memory-mapped I/O
  
# Takes an equation from the keyboard and calculates the sum
# No Preconditions
char1_l:
  li   $s2, '\n'                # Load a newline constant
  lb   $t0, 0($s1)              # Load a character from the keyboard
  beq  $t0, $s2, end            # If the character was the newline, stop looping
  beq  $t0, $zero, char1_l      # If it is the null terminator, start over
  subi $t0, $t0, 48             # Convert to decimal
  
char2_l:
  lb   $t1, 0($s1)              # Load a character from the keyboard
  beq  $t1, $zero, char2_l      # If it is the null terminator, start over
  beq  $t1, $s2, print          # If the character was the newline, stop looping

char3_l:
  lb   $t1, 0($s1)              # Load a character from the keyboard
  beq  $t1, $zero, char3_l      # If it is the null terminator, start over
  subi $t1, $t1, 48             # Convert to decimal
  add  $t0, $t0, $t1            # sum += input val
  j    char2_l                  # Restart waiting for a new add

print:
  add  $a0, $t0, $zero          # Set parameter
  jal  print_decimal_number     # Call 'print_decimal_number' to print sum
  j    main                     # Restart

end:
  j    HALT                     # Enable halt pin and stop the PC incrementing  lb  $t0, 0($s1)

# Determines the remainder of two numbers. 
# Preconditions: Numbers cannot be negative.
# Returns: $a0 % $a1 into $v0
remainder:
  slt  $t0, $a0, $a1            # a < b
  bne  $t0, $zero, end_rem      # if a < b then:
loop_rem:  
  sub  $a0, $a0, $a1            # a = a - b
  slt  $t0, $a0, $a1            # a < b
  beq  $t0, $zero, loop_rem     # if !(a < b), loop
end_rem:                              
  add  $v0, $zero, $a0          # Set return to remainder
  jr   $ra                      # Return to caller

# Determines the quotient of two numbers. 
# Preconditions: Numbers cannot be negative.
# Returns $a0 / $a1 into $v0
quotient:
  addi $t1, $zero, 0            # reset t1
  slt  $t0, $a0, $a1            # a < b
  bne  $t0, $zero, end_quo      # if a < b then:
loop_quo:
  sub  $a0, $a0, $a1            # a = a - b
  slt  $t0, $a0, $a1            # a < b
  addi $t1, $t1, 0x1            # counter++
  beq  $t0, $zero, loop_quo     # if !(a < b), loop
end_quo:                              
  add  $v0, $zero, $t1          # Set counter to return value
  jr   $ra                      # Return to caller  
  
  
# Prints nonnegative decimal numbers to the terminal by printing its digits one by one via the ASCII system.
# Preconditions: decimal number must be nonnegative and provided in $a0
# Prints out the decimal number to terminal
print_decimal_number:
  li   $t3, TERM                # Loads terminal address to $t3                  
  bne  $a0, $zero, else_print   # If decimal number is 0, print '0' to terminal, else branch to 'else_print'
  li   $t0, 0x30                # Load ASCII value for '0'
  sb   $t0, 0($t3)              # Print '0' 
  jr   $ra

else_print: 
  # Sets up and loads the stack
  push $a0                      # Storing $a0 to the stack
  push $ra                      # Storing the original return address to the stack

  # Sets up $a1 as a parameter for remainder and then calls remainder, storing the result in $s1
  li   $a1, 10                  # $a1 = 10
  jal  remainder                # Call remainder to calculate the remainder between n and 10
  add  $s1, $zero, $v0          # int digit = n % 10

  # Retrieves information from the stack and deallocates the space
  pop  $ra                      # Loading $a0 from the stack
  pop  $a0                      # Loading the original return address from the stack

  # Set up to check if n > digit 
  sub  $t2, $s1, $a0            # $t2 = digit - n
  slt  $t2, $t2, $zero          # Checks if $t2 < 0

  # Set up the stack and parameters for quotient. Call quotient.
  push $s1                      # Storing the 'digit' to the stack
  push $ra                      # Storing the original return address to the stack
  li   $a1, 10                  # $a1 = 10

  # Check if n > digit and branch to 'exit_print' if false
  beq  $t2, $zero, exit_print   # If $t2 = 0, then branch to exit_print
  jal  quotient                 # Call quotient to divide n/10

  # Set up and execute recursive call to 'print_decimal_number'
  add  $a0, $zero, $v0          # Set the parameter for the recursion call to 'digit'
  jal  print_decimal_number     # Recurse call to print_decimal_number


exit_print:
  pop  $ra                      # Loading the original return address from the stack
  pop  $s1                      # Loading $s1 from the stack
  addi $t0, $s1, 0x30           # $t0 = 0 + digit
  sb   $t0, 0($t3)              # Print '0 + digit'
  jr   $ra                      # Return to Caller

  