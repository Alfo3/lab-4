#   DESAFIO 1

.data
prompt_n:      .asciz "Ingrese n (cantidad de IDs): "
prompt_id:     .asciz "Ingrese ID: "

txt_id:        .asciz "ID: "
txt_pasos:     .asciz "\nPasos: "
txt_rango:     .asciz "\nRango: "

txt_lider:     .asciz "LIDER\n\n"
txt_operador:  .asciz "OPERADOR\n\n"
txt_inform:    .asciz "INFORMANTE\n\n"
txt_peon:      .asciz "PEON\n\n"

.align 2
ids: .space 80      

.text
.globl main
main:

    # LEER n

    la a0, prompt_n
    li a7, 4
    ecall

    li a7, 5        # read int
    ecall
    mv s0, a0       # s0 = n (contador para lectura)
    mv s3, a0       # s3 = n original (para procesar)

    la s1, ids      # s1 = puntero escritura IDs

read_ids:
    beqz s0, start_processing

    la a0, prompt_id
    li a7, 4
    ecall

    li a7, 5
    ecall
    sw a0, 0(s1)

    addi s1, s1, 4
    addi s0, s0, -1
    j read_ids



# PROCESAR IDs

start_processing:

    la s4, ids    # t0 = puntero IDs
    li t1, 0        # contador procesados

process_loop:
    bge t1, s3, end_program   # si ya procesamos n original se termina

    lw s2, 0(s4)   
    beqz s2, end_program

    #"ID: "
    la a0, txt_id
    li a7, 4
    ecall

    # imprimir número ID
    mv a0, s2
    li a7, 1
    ecall

    # ---- LLAMAR RECURSIVO ----
    
    mv a0, s2     # n
    mv a1, s2     # max inicial = n
    li a2, 0      # pasos inicial

    jal ra, collatzRec

    # al volver:
    # a0 = pasos

    mv t6, a0      # t6 = pasos

    # imprimir texto pasos
    la a0, txt_pasos
    li a7, 4
    ecall

    # imprimir número pasos
    mv a0, t6
    li a7, 1
    ecall

    # CLASIFICACIÓN
    
    mv t4, t6  # t4 = pasos

    li t5, 100
    bge t4, t5, print_lider

    li t5, 50
    bge t4, t5, print_operador

    li t5, 20
    bge t4, t5, print_inform

    j print_peon

print_lider:
    la a0, txt_rango
    li a7, 4
    ecall
    la a0, txt_lider
    li a7, 4
    ecall
    j next_id

print_operador:
    la a0, txt_rango
    li a7, 4
    ecall
    la a0, txt_operador
    li a7, 4
    ecall
    j next_id

print_inform:
    la a0, txt_rango
    li a7, 4
    ecall
    la a0, txt_inform
    li a7, 4
    ecall
    j next_id

print_peon:
    la a0, txt_rango
    li a7, 4
    ecall
    la a0, txt_peon
    li a7, 4
    ecall

next_id:
    addi s4, s4, 4
    addi t1, t1, 1
    j process_loop



#  RECURSIÓN: collatzRec(n, max_val, steps)
#
#  ENTRADAS:
#      a0 = n
#      a1 = max_val
#      a2 = steps
#
#  SALIDAS:
#      a0 = pasos finales
#      a1 = max alcanzado


collatzRec:

    # Caso base n == 1
    li t0, 1
    beq a0, t0, collatz_base

    # Actualizar max si corresponde
    bge a0, a1, update_max
    j skip_update

update_max:
    mv a1, a0
    
skip_update:

    # guardar ra y parámetros (a0,a1,a2)
    addi sp, sp, -16
    sw ra, 12(sp)
    sw a1, 8(sp)
    sw a2, 4(sp)
    sw a0, 0(sp)

    # Calcular siguiente valor 
    andi t1, a0, 1
    beqz t1, even_case

    # ------------ IMPAR -------------
    
    lw t2, 0(sp)       # t2 = n
    add t2, t2, t2     # 2n
    lw t3, 0(sp)
    add t2, t2, t3     # 3n
    addi a0, t2, 1     # next = 3n+1
    j after_calc

even_case:

    # ------------ PAR ---------------
    lw t2, 0(sp)
    srli a0, t2, 1     # next = n/2

after_calc:
    lw a1, 8(sp)       # restaurar max actual
    lw a2, 4(sp)       # restaurar pasos actuales
    addi a2, a2, 1     # steps + 1

    jal ra, collatzRec  # llamada recursiva 

    lw ra, 12(sp)      # restaurar ra
    addi sp, sp, 16    # restaurar sp
    jr ra


collatz_base:
    mv a0, a2
    lw ra, 12(sp)
    addi sp, sp, 16
    jr ra
   

end_program:
    li a7, 10
    ecall
