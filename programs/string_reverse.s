# 'string_reverse' takes input from the keyboard and reverses what was inputted.
.constant HALT      0xff00
.constant TERM      0xff10
.constant KBD       0xff20
.constant STACK_TOP 0xf800

nop
main:
  li    $s0, TERM             # Address of the terminal output for memory-mapped I/O
  li    $s1, KBD              # Address of the keyboard input for memory-mapped I/O
  li    $sp, STACK_TOP        # Predefined initial stack address

take_string:
  lb    $t0, 0($s1)           # Load a character from the keyboard
  beq   $t0, $zero, loop_top  # If it is the null terminator, start over
  addi  $sp, $sp, 3
  sb    $ra, 0($sp)   
  sb    $t0, 2($sp)           # Write the character to the stack
  li    $t1, '\n'             # Load a newline constant
  beq   $t0, $t1, string_rev  # If the character was the newline, branch to 'string_rev'
  jal   take_string           # Start over  

string_rev:
  lb    $    
  j   HALT                    # Enable halt pin and stop the PC incrementing