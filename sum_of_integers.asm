.data

prompt: .asciiz "Please Input a value for N: "

.text

main:
  li $v0, 4
  la $a0, prompt
  syscall

  li $v0, 5
  syscall

  move $a0, $v0
  move $v0, $zero
  jal sum_integers

  move $a0, $v0
  li $v0, 4
  syscall

  li $v0, 10
  syscall


sum_integers:
  beqz $a0, base_case

  add $v0, $v0, $a0
  sub $a0, $a0, 1

  sub $sp, $sp, 4
  sw $ra, 0($sp)

  jal sum_integers

  lw $ra, 0($sp)
  add $sp, $sp, 4

base_case:
  jr $ra
