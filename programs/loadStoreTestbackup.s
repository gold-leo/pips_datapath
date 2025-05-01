# This is a sample assembly program that allows you to test the implementation of an addi instruction in your PIPS datapath.

nop                      # Nop to start the program
li    $sp, 0xf800        # Create starting address for the stack

li    $t0, 0xFFFF        # $t0 = 0xFFFF
li    $t1, 2             # $t1 = 2
addi  $sp, $sp, -8       # Alocate space in the stack for both integers
sw    $t0, 0($sp)        # Store 0xFFFF in the stack
sw    $t1, 4($sp)        # Store 2 in the stack
lw    $t0, 4($sp)        # $t0 = 2
lw    $t1, 0($sp)        # $t1 = 0xFFFF

lb    $t0, 4($sp)        # $t0 = 2
lb    $t1, 0($sp)        # $t1 = 0x00FF
lw    $t2, 0($sp)        # $t2 = 0xFFFF
sw    $zero, 0($sp)      # Clear stack by setting it to $zero
sw    $zero, 4($sp)      # Clear stack by setting it to $zero
addi  $sp, $sp, 8        # Deallocate the stack

