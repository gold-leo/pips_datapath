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