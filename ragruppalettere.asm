.data
  stringa: .ascii "S0pra l1 pa3n8a la C1p7ra"

.text
main:
  # Imposta i parametri ed esegue la chiamata.
  li $a0, 0
  li $a1, 24
  jal ragruppa_lettere

  # Stampa a video la stringa.
  la $a0, stringa
  li $v0, 4
  syscall

  # Terminazione del programma.
  li $v0, 1
  syscall

ragruppa_lettere:
  # Caso base
  beq $a0, $a1, return

  # Preservo il valore dell'indice contenuto
  # all'interno del registro $a0, carico il
  # carattere all'indice $a0 ed determino se
  # si tratta di una lettere oppure no.
  # Ripristino poi il contenuto del registro $a0
  move $a2, $a0
  lb $a0, stringa($a0)
  jal is_letter

  # Se il carattere ad $a0 non e' una lettere
  # effettua una salto all'etichetta 'not_a_char',
  # altrimenti somma 1 ad $a0 e procede a saltare
  # all'etichetta 'recursive_call'.
  beqz $v0, not_a_char
  move $a0, $a2
  addi $a0, $a0, 1
  j recursive_call

not_a_char:
  lb $t1, stringa($a1)
  sb $a0, stringa($a1)
  sb $t1, stringa($a0)
  sub $a1, $a1, 1
  move $a0, $a2

# Esegue la chiamata ricorsiva,
# ripristina quindi lo stack.
# Ritorna infine all'invocante.
recursive_call:
  sub $sp, $sp, 4
  sw $ra, 0($sp)
  jal ragruppa_lettere
  lw $ra, 0($sp)
  addi $sp, $sp, 4

return:
  jr $ra


# Fornisce all'interno del registro
# $v0 il carattere della stringa
# all'indice $a0.
get_char:
  sll $v0, $a0, 3
  lw $v0, stringa($v0)
  jr $ra


# Restituisce 1 se il contenuto
# del registro $a0 rappresenta
# una lettera, altrimenti 0.
is_letter:
  sge $t0, $a0, 'a'
  sle $t1, $a0, 'z'
  sge $t2, $a0, 'A'
  sle $t3, $a0, 'Z'
  and $t0, $t0, $t1
  and $t1, $t2, $t3
  or $v0, $t0, $t1
  jr $ra
