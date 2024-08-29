.data 
helloworld: .asciiz "Hello World!"

.text
li $v0, 4
la $a0, helloworld
syscall

li $v0, 10
syscall