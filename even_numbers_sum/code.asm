       .data
array: .word 0,1,2,3,4,5,6,7,8,9,10,-1,-2,-3,-56,-9

###############################################################################
        .text 
        la         $a0, array           # $a0 gets the address of the first element in the array.
        li         $a1, 16              # $a1 gets the number of integers in the array.
###############################################################################


even_sum:

	add $v0, $zero, $zero          # $v0 is initialized to value 0.
loop:
	beq  $zero, $a1, exit          # if value in $a1 == 0 (0 elements to be checked left) goto label exit else do nothing( proceed to next line).
	addi $a1, $a1, -1              # count index of elements to be checked decreaded by one.
	lw   $t0, 0($a0)               # $t0 gets the value which is at the address $a0 contains.
	addi $a0, $a0, 4               # Pointer move 4 bytes forward (i++).
	slt  $t1, $zero, $t0           # possitive number check  | if  $zero < $t0 then $t1 = 1 else $t1 = 0 
	beq  $t1, $zero, loop          # if $t1 == 0 which means the number is negative, go to label loop else do nothing ( proceed to next line).
	andi $t1, $t0, 1               # less significant bit check to determine number nature || If bit  == 0 then then $t1 == 0 (number is odd). If bit is 1 then $t1 = 1 (number is even)
	bne  $t1, $zero, loop          # if value in $t1 == 0 (number is odd) goto label loop else do nothing( proceed to next line)
	add  $v0, $v0, $t0             # Number is even . $v0 = $v0 + $t0  ($v0 -> sum , $t0 -> number)
	j loop			 # goto label loop.
exit:


##############################################################################################
        syscall

