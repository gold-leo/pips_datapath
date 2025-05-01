nop
li  $t0, 0xff10
li  $s1, 0xFF0     # 0x0FF0
sw  $s1, 0($t0)
srl $s1, $s1, 4    # Expected: 0x00FF
sw  $s1, 0($t0)
sll $s1, $s1, 8    # Expected: 0xFF00
sw  $s1, 0($t0)
sra $s1, $s1, 4    # Expected: 0xFFF0
sw  $s1, 0($t0)