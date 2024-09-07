.macro done
	li $v0, 10
	syscall
.end_macro

.macro return (%exitcode)
	li $v0, 17
	li $a0, %exitcode
	syscall
.end_macro

.macro incr_reg (%reg)
	addi %reg, %reg, 1
.end_macro

.macro decr_reg (%reg)
	addi %reg, %reg, -1
.end_macro

.macro push_word (%reg)
	addi $sp, $sp, -4
	sw %reg, 0($sp)
.end_macro

.macro pop_word (%reg)
	lw %reg, 0($sp)
	addi $sp, $sp, 4
.end_macro
	