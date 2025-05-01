# This file contains the program that tests all the load/store instructions in Lab 9.

# Start program with a 'nop' and create a starting address for the stack
nop                              # Nop to start program
li    $sp, 0xf800                # Set starting address for the stack

# Create "Hello, World!" in 'text' segment
  li $t0, 0xFFFF    # String Pointer
  li $t1, 0x4865    # "He"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2
  li $t1, 0x6c6c    # "ll"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2
  li $t1, 0x6f2c    # "o,"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2
  li $t1, 0x2077    # " W"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2
  li $t1, 0x6f72   # "or"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2
  li $t1, 0x6c64    # "ld"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2
  li $t1, 0x2100    # "!\n"
  sw $t1, 0($t0)   
  addi $t0, $t0, -2

li    $a0, 24                    # Set $a0 = 24
li    $a1, 16                    # Set $a1 = 16
jal   gcd                        # Call remainder
add   $s2, $zero, $v0            # Store result in $s2; $s2 = 8
infinite_loop:
j     infinite_loop

# Finds the remainder of two numbers.
remainder:
  slt  $t0, $a0, $a1              # a < b
  bne  $t0, $zero, end            # if a < b then:
loop_r:
  sub  $a0, $a0, $a1              # a = a - b
  slt  $t0, $a0, $a1              # a < b
  beq  $t0, $zero, loop_r         # if !(a < b), loop
end:                              
  add  $v0, $zero, $a0            # Set return to remainder
  jr   $ra                        # Return to caller  


gcd:
  bne  $a1, $zero, else           # if (n==0)
  add  $v0, $zero, $a0            # Set return to m
  jr   $ra                        # Return to caller
else:
  addi $sp, $sp, -8               # Allocate space on the stack
  sw   $a1, 0($sp)                # Push n onto the stack
  sw   $ra, 4($sp)                # Push return address onto the stack
  jal  remainder                  # Call remainder
  lw   $a0, 0($sp)                # Load n from stack into first param
  add  $a1, $zero, $v0            # Set remainder() to second param
  jal  gcd                        # Call gcd
  lw   $ra, 4($sp)                # Load return address from stack
  addi $sp, $sp, 8                # Deallocate stack
  jr   $ra                        # Return to caller  


# Reverse a string.
reverse:
# First, we need to index a pointer until we find the null character.
  move $t0, $a0                  # Create a pointer starting at the beginning of the string
  lbu  $t1, 0($t0)               # Get byte from word
  beq  $t1, $zero, rev_loop      # If null, end loop
loop_r1:
  lbu  $t1, 1($t0)               # Get byte from word
  beq  $t1, $zero, rev_loop      # If null, end loop
  nop                            # [delay slot]
  addi $t0, $t0, 1               # Increment to next byte
  j    loop_r1                   # Loop
# Next, we need to swap each letter with the letter in the position it is supposed to be.
rev_loop:
  lbu  $t2, 0($a0)               # Load "a" pointer
  lbu  $t1, 0($t0)               # Load "t" pointer
  sb   $t2, 0($t0)               # Store *a into *t
  sb   $t1, 0($a0)               # Store *t into *a
  addi $t0, $t0, -1              # Increment t backwards
  addi $a0, $a0, 1               # Increment a forwards
  slt  $t3, $a0, $t0             # Check if a < t
  bne  $t3, $zero, rev_loop      # If so, loop again
  jr $ra                         # Return to caller
 





