# This file contains the tests for all the jump instructions in Lab 9.

# jump testing
nop
li   $t1, 4            # t1 == 4
jal  INCREMENT         # jump to INCREMENT
li   $t2, 1            # t2 == 1 if jump fails
j   JUMPTEST

INCREMENT:
addi  $t1, $t1, 1      # t1 == 5
jr    $ra              # Jump to Return Address

JUMPTEST:
add $t2, $t2, $t2      # t2 == 2


