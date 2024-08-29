.data
	array: .word 
		120, 1, 42,  2,  1
		32, 10, 77,  6,  1
		21, 82, 12,  4,  1
		55,  3,  8,  1,  1
		1,   1,  1,  1,  1
		
	lato:  .word 5

.text
main:
	li $a0, 0      # x = 0
	li $a1, 0      # y = 0
	lw $a2, lato   # Carico il lato della matrice
	li $t0, 0      # Somma = 0
	
	cicloY:
		bge $a1, $a2, exit       # y >= lato
	cicloX:
		bge $a0, $a2, next_y     # x >= lato
		jal is_diagonal          # array[y][x] e' diagonale ?
		beqz $v0, next_x         # non e' diagonale
		jal read_2d_matrix_el    # legge l'elemento array[y][x]
		add $t0, $t0, $v0        # somma += array[y][x]
  
	next_x:
		addi $a0, $a0, 1         # x += 1
		j cicloX          
	next_y:
		addi $a1, $a1, 1         # y += 1
		li $a0, 0                # x = 0
		j cicloY 
	
	exit:
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 10
		syscall


is_diagonal:
	beq $a0, $a1, is_diagonal_yes  # x == y
	add $v0, $a0, $a1              # x+y
	addi $v0, $v0, 1               # x+y+1
	beq $v0, $a2, is_diagonal_yes  # x+y+1 == lato
	li $v0, 0
	jr $ra
	
is_diagonal_yes:
	li $v0, 1
	jr $ra
	

read_2d_matrix_el:
	mul $v0, $a1, $a2  # y * lato
	add $v0, $v0, $a0  # + x
	sll $v0, $v0, 2    # * 4 (word size)
	lw $v0, array($v0)
	jr $ra
