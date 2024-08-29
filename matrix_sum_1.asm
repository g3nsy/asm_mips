# Problema:
# Sommare i valori contenuti nella diagonale 
# di una matrice bidimensionale.

.data

array: .word
	1, 10, 4, 2
	2, 3, 32, 7
	5, 0, 22, 88
	9, 2, 13, 66

length: .word 4

# Pseudo:
# 1) Calcolo dell'indirizzo finale del vettore 
#    per implementare la condizione dell'istruzione
#    di salto condizionato per terminare il loop.

.text	 
	li $t2, 0           # Inizializzo la somma al valore 0.
	
	la $t0, array       # Carico l'indizzo dell'array.
	lw $t1, length      # Carico la dimensione della matrice.
	mul $t3, $t1, $t1   # Calcolo del numero di elementi della matrice.
	sll $t3, $t3, 2     # Calcolo la dimensione in byte degli elementi della matrice.
	add $t3, $t0, $t3   # Calcolo l'indizzo finale del vettore.
	
	loop: 	bge $t0, $t3, endloop  # Condizione di terminazione del loop.
		lw $t4, $t0            # Carico il valore da sommare.
		add $t2, $t2, $t4      # Incremento la variabile $t2 (Somma parziale)
		addi $t0, $t0, 4       # Passo direttamente al successivo indirizzo da considerare.
				
	endloop:
		li $v0, 1
		move $a0, $t2
		syscall
		li $v0, 10
		syscall
