.data
	N: .word 6

.text
	main:
		lw $a0, N
		jal calcola_fattoriale_ricorsivo
		move $a0, $v0
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall

	#################################
	# Calcola il fattoriale di $a0  #
	# in modo iterativo.            #
	# Restituisce il risultato      #
	# all'interno di $v0            #
	#################################
	calcola_fattoriale_iterativo:
		li $v0, 1  # Fattoriale di N
		loop:
			ble $a0, 1, return_iterative
			mul $v0, $a0, $v0
			subi $a0, $a0, 1
			j loop
		return_iterative:
			jr $ra
			
			
	#################################
	# Calcola il fattoriale di $a0  #
	# in maniera ricorsiva.         #
	# Restituisce il risultato      #
	# all'interno di $v0            #
	#################################		
	calcola_fattoriale_ricorsivo:
		beqz $a0, return_recursive
		
		# Allocazione
		subi $sp, $sp, 8  # Allocazione di due word nello stack
		sw $ra, 0($sp)    # Carico ra nello stack
		sw $a0, 4($sp)    # Carico a0 nello stack
		
		sub $a0, $a0, 1
		jal calcola_fattoriale_ricorsivo  # Calcolo il fattoriale di N-1
		
		# Disallocazione
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		addi $sp, $sp, 8
		
		mul $v0, $a0, $v0                 # N * N-1
		jr $ra
		return_recursive:
			li $v0, 1
			jr $ra