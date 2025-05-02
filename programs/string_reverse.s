# 'string_reverse' takes input from the keyboard and reverses what was inputted.
# Credit to Charlie Curtsinger for the code to input and output via keyboard and terminal respecitvely.
.constant HALT      0xff00
.constant TERM      0xff10
.constant KBD       0xff20
.constant STACK_TOP 0xf800

nop
main:
  li    $s0, TERM             # Address of the terminal output for memory-mapped I/O
  li    $s1, KBD              # Address of the keyboard input for memory-mapped I/O
  li    $sp, STACK_TOP        # Predefined initial stack address
  jal   take_string           # Call take-string
  j     HALT                  # Enable halt pin and stop the PC incrementing

# Takes characters from a keyboard input until a newline character (\n) is inputted
# No Preconditions
# Postconditions: The stack contains all return addresses and characters 
#                 inputted expect the newline character.
take_string:
  lb    $t0, 0($s1)           # Load a character from the keyboard
  li    $t1, '\n'             # Load a newline constant
  beq   $t0, $zero, take_string  # If it is the null terminator, start over
  beq   $t0, $t1, string_rev  # If the character was the newline, branch to 'string_rev'
  addi  $sp, $sp, -4          # Allocate stack
  sw    $ra, 0($sp)           # Store return address to stack
  sb    $t0, 2($sp)           # Write the character to the stack
  jal   take_string           # Start over 
   
# Takes characters from the stack and prints them in reverse order to the terminal.
# No preconditions. 
# Postconditions: Terminal prints characters in reverse order.
string_rev:
  lb    $t0, 2($sp)           # Retrieves return address from the stack
  lw    $ra, 0($sp)           # Retrieves most recent character from the stack
  sb    $t0, 0($s0)           # Write the character to the terminal
  addi  $sp, $sp, 4           # Deallocate stack
  jr    $ra                   # Return to caller