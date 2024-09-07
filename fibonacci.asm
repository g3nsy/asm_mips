# Calcolo della serie di Fibonacci

.data
N: .word 10

.text
main:
  lw $a0, N
  jal fibonacci

  move $a0, $v0
  li $v0, 1
  syscall

  li $v0, 10
  syscall

fibonacci:
  # if N > 2
  # fibonacci(N) = fibonacci(N - 1) + fibonacci(N - 2)
  # else
  # 1
  ble $a0, 2, base_case

  subi $sp, $sp, 8
  sw $ra, 0($sp)
  sw $a0, 4($sp)

  subi $a0, $a0, 1  # $a0 = N - 1
  jal fibonacci  # fibonacci(N - 1)

  move $t0, $v0  # memorizzo fibonacci (N - 1)

  # Ripristino ra ed a0
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  addi $sp, $sp, 8

  sub $sp, $sp, 8
  sw $ra, 0($sp)
  sw $a0, 4($sp)

  subi $a0, $a0, 2  # $a0 = N - 2
  jal fibonacci

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  addi $sp, $sp, 8

  add $v0, $t0, $v0
  jr $ra

base_case:
  li $v0, 1
  jr $ra
