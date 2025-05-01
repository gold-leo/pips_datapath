# This file contains the tests for all the instructions in Lab 8.

# addi/add testing
li   $t1, 4            #t1 == 4
addi $t2, $t1, 1       #t2 == 5
add  $t3, $t1, $t2     #t3 == 9

# sub/subi testing
sub  $t3, $t3, $t2     #t3 == 4
subi $t3, $t3, 3       #t3 == 1

# and/andi testing
li   $t0, 0x001A         #t0 == 0x001A
li   $t1, 0x000A         #t1 == 0x000A 
and  $t2, $t0, $t1       #t2 == 0x000A
andi $t2, $t0, 0x0008    #t2 == 0x0008

# or/ori testing
li   $t0, 0x001A         #t0 == 0x001A
li   $t1, 0x000A         #t1 == 0x000A 
or   $t2, $t0, $t1       #t2 == 0x001A
ori  $t2, $t0, 0x002A    #t2 == 0x003A

# nand/nandi testing
li     $t0, 0x001A         #t0 == 0x001A
li     $t1, 0x000A         #t1 == 0x000A 
nand   $t2, $t0, $t1       #t2 == 0xFFF5
nandi  $t2, $t0, 0x001A    #t2 == 0xFFE5

# nor/nori testing
li     $t0, 0x001A         #t0 == 0x001A
li     $t1, 0x000A         #t1 == 0x000A  
nor    $t2, $t0, $t1       #t2 == 0xFFe5
nori   $t2, $t0, 0x002A    #t2 == 0xFFc5

# xor/xori testing
li     $t0, 0x001A         #t0 == 0x001A
li     $t1, 0x000A         #t1 == 0x000A 
xor    $t2, $t0, $t1       #t2 == 0x0010
xori   $t2, $t0, 0x002A    #t2 == 0x0030

# slt/slti testing
li   $s0, 4            #s0 == 4
li   $s1, -1           #s1 == -1
slt  $t0, $s1, $s0     #t0 == 1
slt  $t1, $s0, $s1     #t1 == 0
slti $t2, $s0, -1      #t2 == 0
slti $t3, $s0, 5       #t3 == 1

# sltu/sltui testing
sltu   $t0, $s1, $s0   #t0 == 0
sltu   $t1, $s0, $s1   #t1 == 1
sltiu  $t2, $s0, -1    #t2 == 1
sltiu  $t3, $s1, 3     #t3 == 0


