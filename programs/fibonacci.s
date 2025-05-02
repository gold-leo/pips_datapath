# Print the first 15 numbers of the fibonacci sequence to the PIPS terminal
# Charlie Curtsinger
.constant TERMINAL 0xff10
.constant HALT     0xff00

main:
  nop                           # First instruction does not execute
  li $sp, 0xf800                # Loads a starting address for the stack to $sp

# Fibonnaci sequence
  li   $s0, 1                   # Load the number of fib numbers we want to print
fib_loop:
  addi $a0, $s0, 0              # Move i to param
  jal  fib                      # Call fib(i)
  add  $a0, $zero, $v0          # Move fib(i) to param
  jal  print_decimal_number     # Call print_decimal_number(result)
  li   $t0, 0x000A              # Load '\n'
  li   $t1, TERMINAL            # Load TERMINAL
  sw   $t0, 0($t1)              # Print '\n'
  addi $s0, $s0, 1              # Increment i
  addi $t0, $s0, -16            # i - 16 (should be zero on break case)
  bne  $t0, $zero, fib_loop     # if (i - 16 != 0), loop
  j    HALT                     # HALT the program


# Determines the ith fibonacci number. 
# Preconditions: $a0 > 0
fib:
  slti  $t0, $a0, 3             # i < 3
  beq   $t0, $zero, fib_recur   # if (i < 3), recursive case
  addi  $v0, $zero, 1           # return value to 1
  jr    $ra                     # Return to caller
fib_recur:
  push  $ra                     # Push return address
  push  $a0                     # Push first param
  addi  $a0, $a0, -1            # i - 1
  jal   fib                     # Recursively call fib(i-1)
  pop   $a0                     # Load first param
  push  $v0                     # Push fib(i-1)
  addi  $a0, $a0, -2            # i - 2
  jal   fib                     # Recursively call fib(i-2)
  pop   $t0                     # Load fib(i-1)
  add   $v0, $v0, $t0           # fib(i-1) + fib(i-2)
  pop   $ra                     # Load return address
  jr    $ra                     # Return to caller

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
  li   $t3, TERMINAL            # Loads terminal address to $t3                  
  bne  $a0, $zero, else_print   # If decimal number is 0, print '0' to terminal, else branch to 'else_print'
  li   $t0, 0x30                # Load ASCII value for '0'
  sb   $t0, 0($t3)              # Print '0' 
  jr   $ra

else_print: 
  # Sets up and loads the stack
  push  $a0                     # Storing $a0 to the stack
  push  $ra                     # Storing the original return address to the stack

  # Sets up $a1 as a parameter for remainder and then calls remainder, storing the result in $s1
  li   $a1, 10                  # $a1 = 10
  jal  remainder                # Call remainder to calculate the remainder between n and 10
  add  $s1, $zero, $v0          # int digit = n % 10

  # Retrieves information from the stack and deallocates the space
  pop   $ra                     # Loading $a0 from the stack
  pop   $a0                     # Loading the original return address from the stack

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
