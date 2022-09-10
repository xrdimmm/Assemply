        .data
array:  .word 5, 6, 7, 8, 9, 0, 1, 2, 3, 4    # array initialization
        .text 
###############################################################################################
        la         $a0, array                 # $a0 gets the address of the label array.
        li         $a1, 10                    # $a1 gets the number of elements in the array.


swapArray:

        sll $t0, $a1 ,1                      # (size/2)*4 = 2*size || $t0 gets the number of bytes between array[0] to array[size/2].
        add $t0, $t0, $a0                    # $t0 gets the address of the array[size/2].
        add $t3, $t0, $zero 		     # $t0 is coppied to $t3 || An other pointer to array[size/2] address.
loop:	
	beq $t3, $a0, break                  # if address $t3 contains == address $a0 contains goto label break else do nothing (proceed to next line).
	lw $t1, 0($a0)                       # $t1 gets the value of array[i]. $a0 has the address of array[i].
	lw $t2, 0($t0)                       # $t2 gets the value of array[size/2 + i]. $t0 has the address of array[size/2 +i].
	sw $t1, 0($t0)                       # Store the value of $t1 at the address $t0 contains. (array[size/2+i] = array[i]).
	sw $t2, 0($a0)                       # Store the value of $t2 at the address $a0 contains. (array[i] = array[size/2+i]).
	addi $t0, $t0, 4                     # Pointer move 4 bytes forward (i++).
	addi $a0, $a0, 4                     # Pointer move 4 bytes forward ( ((size/2)+i)++ ).
	j loop                               # goto label loop.
break:

###############################################################################################
exit:
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall                      # we are outta here.

