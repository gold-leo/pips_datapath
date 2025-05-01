# This file contains the tests for all the branch instructions in Lab 9.

# beq  testing
nop
li   $t1, 4            # t1 == 4
li   $t2, 3            # t2 == 3
beq  $t1, $t2, BNE     # Branch to BEQ if $t1 == $t2 not taken  
addi $t2, $t2, 1       # t2 == 4 if branch fails
beq  $t1, $t2, BNE     # Branch to BEQ if $t1 == $t2 taken
addi $t2, $t2, 1       # t2 == 5 if branch fails

# bne testing
BNE:
li   $t1, 5            # t1 == 5
li   $t2, 5            # t2 == 5
bne  $t1, $t2, EXIT    # Branch to EXIT if $t1 != $t2  not taken
addi $t2, $t2, 1       # t2 == 6 if branch fails
bne  $t1, $t2, EXIT    # Branch to EXIT if $t1 != $t2 taken
addi $t2, $t2, 1       # t2 == 7 if branch fails

# End Program
EXIT:
nop                    # nop to exit



