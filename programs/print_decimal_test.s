.constant TERMINAL 0xff10
.constant HALT     0xff00

main:
  nop              # First instruction does not execute
  li $sp, 0xf800   # Loads a starting address for the stack

  # li $t2, TERMINAL
  # li $a0, 21
  # li $a1, 10
  # jal remainder
  # addi $v0, $v0, 0x30
  # sw $v0, 0($t2)

  li  $a0, 212
  jal print_decimal_number
  li  $a0, 377
  jal print_decimal_number

 j HALT

# Determines the remainder of two numbers. Numbers cannot be negative.
# Returns a % b
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

# Determines the quotient of two numbers. Numbers cannot be negative.
# Returns a / b
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
  li   $t3, TERMINAL            # Loads terminal address to $t3                  
  bne  $a0, $zero, else_print   # If decimal number is 0, print '0' to terminal, else branch to 'else_print'
  li   $t0, 0x30                # Load ASCII value for '0'
  sb   $t0, 0($t3)              # Print '0' 
  jr   $ra

else_print: 
  # Sets up and loads the stack
  addi $sp, $sp, -4             # Allocate space in the stack
  sw   $a0, 0($sp)              # Storing $a0 to the stack
  sw   $ra, 2($sp)              # Storing the original return address to the stack

  # Sets up $a1 as a parameter for remainder and then calls remainder, storing the result in $s1
  li   $a1, 10                  # $a1 = 10
  jal  remainder                # Call remainder to calculate the remainder between n and 10
  add  $s1, $zero, $v0          # int digit = n % 10

  # Retrieves information from the stack and deallocates the space
  lw   $a0, 0($sp)              # Loading $a0 from the stack
  lw   $ra, 2($sp)              # Loading the original return address from the stack
  addi $sp, $sp, 4              # Deallocate space in the stack

  # Set up to check if n > digit 
  sub  $t2, $s1, $a0            # $t2 = digit - n
  slt  $t2, $t2, $zero          # Checks if $t2 < 0

  # Set up the stack and parameters for quotient. Call quotient.
  addi $sp, $sp, -4             # Allocate space in the stack
  sw   $s1, 0($sp)              # Storing the 'digit' to the stack
  sw   $ra, 2($sp)              # Storing the original return address to the stack
  li   $a1, 10                  # $a1 = 10

  # Check if n > digit and branch to 'exit_print' if false
  beq  $t2, $zero, exit_print   # If $t2 = 0, then branch to exit_print
  jal  quotient                 # Call quotient to divide n/10

  # Set up and execute recursive call to 'print_decimal_number'
  add  $a0, $zero, $v0          # Set the parameter for the recursion call to 'digit'
  jal  print_decimal_number     # Recurse call to print_decimal_number


exit_print:
  lw   $ra, 2($sp)              # Loading the original return address from the stack
  lw   $s1, 0($sp)              # Loading $s0 from the stack
  addi $sp, $sp, 4              # Deallocate space in the stack
  addi $t0, $s1, 0x30           # $t0 = 0 + digit
  sb   $t0, 0($t3)              # Print '0 + digit'
  jr   $ra                      # Return to Caller