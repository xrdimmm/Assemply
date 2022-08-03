.globl pdrome

###############################################################################
.data
anna:  .asciiz "anna"
bobob: .asciiz "bobob"

###############################################################################
.text
  la    $a0, anna
  addi  $a1, $zero,17  
  jal   pdrome
  add   $s0, $v0, $zero  # keep the return value

  la    $a0, bobob
  addi  $a1, $zero, 5
  jal   pdrome
  add   $s1, $v0, $zero  # keep the return value
  # both s1 and s0 must be 1 here

  addiu   $v0, $zero, 10    # system service 10 is exit
  syscall                   # we are outa here.


#################################################################################
pdrome:
	sltiu $t0, $a1, 2
	beq $t0, $zero recursion
	
return_1: 
	addi $v0, $zero, 1
	jr $ra

return_0:
	add $v0, $zero, $zero
	jr $ra

recursion:
	add  $t0, $a1, $a0
	lbu  $t1, 0($a0)
	lbu  $t2, -1($t0)
	bne  $t2, $t1, return_0
	addi $a0, $a0,  1
	addi $a1, $a1, -2
	
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	jal pdrome
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra



###############################################################################
  jr $ra

