# gcd(x, y)=x           if x = y
# gcd(x, y)=gcd(y, x)   if x > y
# gcd(x, y)=gcd(x, y-x) if x < y


##########
# Macros #
##########

.macro print_int (%int)
  move $a0, %int
  li $v0, 1
  syscall
.end_macro

.macro exit
  li $v0, 10
  syscall
.end_macro

.macro return
  jr $ra
.end_macro


.data
x: .word 120
y: .word 105

.text
main:
  lw $a0, x  # Loading x
  lw $a1, y  # Loading y
  jal gcd_recursive
  print_int $v0
  exit

# GCD Recursive procedure
gcd_recursive:
  beq $a0, $a1, gcd_recursive_base_case
  sub $sp, $sp, 4
  sw $ra, 0($sp)
  bgt $a0, $a1, gcd_x_greater_than_y_case
  sub $a1, $a1, $a0
  j gcd_recursive_part
gcd_x_greater_than_y_case:
  move $v0, $a0
  move $a0, $a1
  move $a1, $v0
gcd_recursive_part:
  jal gcd_recursive
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  return
gcd_recursive_base_case:
  move $v0, $a0  # same as move $v0, $a1
  return

# GCD Iterative procedure
gcd_iterative:
loop:
  beq $a0, $a1, end_gcd
  bge $a0, $a1, switch_parameters
  sub $a1, $a1, $a0
  j loop
switch_parameters:
  move $a3, $a0
  move $a0, $a1
  move $a1, $a3
  j loop
end_gcd:
  move $v0, $a0
  return
