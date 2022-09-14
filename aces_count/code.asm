        .text
        li         $a0, 15	# set $a0 to a specific number.

#################################################################################

aces_count:
 	add  $v0, $zero, $zero	 # $v0 is initialized to value 0. $v0 will be the sum of aces.
 	addi $t1, $zero, 31	 # $t1 initialized as a counter in order to check every bit of the number.

loop:
	slt  $t2, $t1, $zero	# if $t1 < 0 then $t2 = 1 else $t2 = 0
	bne  $t2, $zero, exit	# if $t2 = 1 then we have checked every bit, go to label exit , else do nothing ( proceed to next line)
	addi $t1, $t1, -1	# counter decreased by one.
	andi $t0, $a0, 1	# logical and in order to take the less significant bit.
	srl  $a0, $a0, 1	# right shift one bit to the number $a0 contains.
	beq  $t0, $zero, loop	# if the bit was not an ace, go to label loop , else do nothing ( proceed to next line)
	addi $v0, $v0, 1	# case when bit was an ace. Increase sum counter by one.
	j loop			# goto label loop.
exit:





#################################################################################
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall
