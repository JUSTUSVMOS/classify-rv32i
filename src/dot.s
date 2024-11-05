.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0         

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    li t2, 0
    li t3, 0

mul_stride_0:
    beq t2, a3, end_stride_0
    add t3, t3, t1 # i * stride_0
    addi t2, t2, 1 # t2++
    j mul_stride_0

end_stride_0:
    slli t3, t3, 2    
    add t4, a0, t3
    lw t4 0(t4)

    li t2, 0 
    li t3, 0

mul_stride_1:
    beq t2, a4, end_stride_1
    add t3, t3, t1
    addi t2, t2, 1
    j mul_stride_1

end_stride_1:
    slli t3, t3, 2
    add t5, a1, t3
    lw t5, 0(t5)

    li t2, 0 
    li t3, 0

mul_loop:
    beq t3, t4, end_mul
    add t2, t2, t5
    addi t3, t3, 1
    j mul_loop

end_mul:
    add t0, t0, t2
    addi t1, t1, 1
    
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
