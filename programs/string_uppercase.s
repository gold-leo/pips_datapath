# Turn any types string into uppercase.
# Credit to Charlie Curtsinger for partial code.
.constant TERM      0xff10
.constant HALT      0xff00
.constant KBD       0xff20
.constant STACK_TOP 0xf800

nop
main:
  li    $s0, TERM            # Address of the terminal output for memory-mapped I/O
  li    $s1, KBD             # Address of the keyboard input for memory-mapped I/O

loop:
  lb    $t0, 0($s1)           # Load a character from the keyboard
  beq   $t0, $zero, loop      # If it is the null terminator, start over
  subi  $t1, $t0, 97          # Subtract for ASCII comparison
  sltiu $t2, $t1, 26          # Compare if $t1 is a lowercase letter
  beq   $t2, $zero, skip      # If $t1 is lowercase, don't make uppercase
  subi  $t0, $t0, 32          # Convert to uppercase
skip:
  sb    $t0, 0($s0)           # Write the character to the terminal
  li    $t1, '\n'             # Load a newline constant
  beq   $t0, $t1, end         # If the character was the newline, stop looping
  j     loop                  # Start over

end:
  j     HALT                  # Enable halt pin and stop the PC incrementing  lb  $t0, 0($s1)
