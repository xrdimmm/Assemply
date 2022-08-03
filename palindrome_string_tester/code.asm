.globl pdrome

###############################################################################
# Storing in memory test strings 

.data
anna:  .asciiz "anna"
bobob: .asciiz "bobob"

###############################################################################
.text

	# 1rst Example :
  la    $a0, anna
  addi  $a1, $zero,17  
  jal   pdrome
  add   $s0, $v0, $zero  # keep the return value

  # 2nd Example :

  la    $a0, bobob
  addi  $a1, $zero, 5
  jal   pdrome
  add   $s1, $v0, $zero  # keep the return value


 
  addiu   $v0, $zero, 10    # system service 10 is exit
  syscall                   # we are outa here.


#################################################################################
pdrome:
	sltiu $t0, $a1, 2           # If $a1 < 2 then $t0 = 1 else $t0 = 0 || Case when string length is 0 or 1.
	beq $t0, $zero recursion    # If $t0 == $zero then goto label -> recursion else do nothing (execute next line).
	
return_1: 
	addi $v0, $zero, 1          # Set the $v0 = 1 || The output of the subroutine when string length is 0 or 1.
	jr $ra                      # Return to caller.

return_0:
	add $v0, $zero, $zero       # Set $v0 = 0 || The output of the subroutine when the string is not palindrome.
	jr $ra                      # Return to caller.

recursion:
	add  $t0, $a1, $a0          # $t0 gets the address of the byte which is JUST AFTER the byte who contains the last char of the string (Pointer).
	lbu  $t1, 0($a0)            # Load in $t1 the first byte of the word at the address -> $a0 contains.
	lbu  $t2, -1($t0)           # Load in $t2 the first byte of the word at the address which is one byte before the the address -> $t0 contains (using offset).
	bne  $t2, $t1, return_0     # If $t1 != $t2 (DIFFERENT ASCII NUMBER => DIFFERENT LETTER) goto label -> return_0
	addi $a0, $a0,  1           # Pointer at the first char of the string move one byte ahead.
	addi $a1, $a1, -2           # String length update. First and last char of the string have been compered. So we decrease string length by 2 chars.
	
	addi $sp, $sp, -4           # Make room for one item in the stack.
	sw   $ra, 0($sp)            # Save return address in the stack.
	jal pdrome                  # Subroutine call with the updated( $a0 , $a1 ) inputs.
	lw $ra, 0($sp)              # Restore return address from the stack.
	addi $sp, $sp, 4            # Restore stack pointer position.
	jr $ra                      # Return to caller.



###############################################################################
  jr $ra

