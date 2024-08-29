.text
move $t0, $zero # max var definition
do:
li $v0, 5 # read integer
syscall
seq $t1, $t0, $zero
sgt $t2, $v0, $t0
or  $t2, $t2, $t1
beqz $t2, endif
move $t0, $v0
endif:
bnez $v0, do

# printf
li $v0, 1
move $a0, $t0
syscall

# exit
li $v0, 10
syscall
