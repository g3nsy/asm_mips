.text
li $t0, 10
li $t1, 2

move $t2, $zero

loop:
beqz $t1, ready     # if $t1 si 000...000 nothing more to do
andi $t3, $t1, 1    # Mask to only have LSB of $t1
beqz $t3, skip
add  $t2, $t2, $t0  # Add $t0 to the result ($t2)

skip:
sra $t1, $t1, 1     # Divide $t1 by 2
sll $t0, $t0, 1     # Multiply $t0 by 2
j loop

ready:
li $v0, 1
move $a0, $t2
syscall

mtlo $t2
li $v0, 10
syscall