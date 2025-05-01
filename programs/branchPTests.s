# Testing the blt!, ble!, bgt! and bge! instructions.
.constant HALT     0xff00

# ble tests
main:
  nop
  li $t0, 1
  li $t1, 2
  bge! $t0, $t1, test1
  li $t1, 1
  li $t0, 2
  bge! $t0, $t1, test1
  j main

test1:
  li $t1, 2
  li $t0, 2
  bge! $t0, $t1, test2
  j test1

test2:
  j HALT

