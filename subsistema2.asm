
.data
prompt_clave:      .asciz "Ingrese clave (16 chars): "
txt_ok:            .asciz "CLAVE ACEPTADA\n"
txt_fail:          .asciz "CLAVE RECHAZADA\nCapa fallida: "
newline:           .asciz "\n"
clave:             .space 20
especiales:        .asciz "!@#$%&*+"

.text
.globl main
main:
    # --- Pedir clave ---
    la a0, prompt_clave
    li a7, 4
    ecall

    la a0, clave
    li a1, 20
    li a7, 8
    ecall

    # --- Limpiar newline del final ---
    la t0, clave
limpiar_newline:
    lb t1, 0(t0)
    beqz t1, fin_limpiar
    li t2, 10              # ASCII de '\n'
    beq t1, t2, quitar_nl
    li t2, 13              
    beq t1, t2, quitar_nl
    addi t0, t0, 1
    j limpiar_newline
quitar_nl:
    sb zero, 0(t0)
fin_limpiar:

    # --- Verificar longitud exacta = 16 ---
    la t0, clave
    li t1, 0
    
contar_len:
    lb t2, 0(t0)
    beqz t2, verificar_len
    addi t1, t1, 1
    addi t0, t0, 1
    j contar_len
verificar_len:
    li t2, 16
    bne t1, t2, fail_capa1  # Si no tiene 16 chars, falla capa 1


    li s7, 16       
    li s8, 4        
    li s9, 65536    
    li s10, 31      
    li s11, 10000   


    #   CAPA 1
    li s0, 0   # mayus count
    li s1, 0   # minus count
    li s2, 0   # dígitos count
    li s3, 0   # especiales count

    la t0, clave
    li t1, 0

capa1_loop:
    bge t1, s7, capa1_done

    lb t2, 0(t0)

    li t3, 'A'
    li t4, 'Z'
    blt t2, t3, check_minus
    bgt t2, t4, check_minus
    addi s0, s0, 1
    j next_char1

check_minus:
    li t3, 'a'
    li t4, 'z'
    blt t2, t3, check_digit
    bgt t2, t4, check_digit
    addi s1, s1, 1
    j next_char1

check_digit:
    li t3, '0'
    li t4, '9'
    blt t2, t3, check_special
    bgt t2, t4, check_special
    addi s2, s2, 1
    j next_char1

check_special:
    la t5, especiales

esp_loop:
    lb t6, 0(t5)
    beqz t6, fail_capa1    # Char no válido -> falla capa 1
    beq t2, t6, is_special
    addi t5, t5, 1
    j esp_loop

is_special:
    addi s3, s3, 1

next_char1:
    addi t1, t1, 1
    addi t0, t0, 1
    j capa1_loop

capa1_done:
    # Verificar conteos exactos = 4
    li t0, 4
    bne s0, t0, fail_capa1
    bne s1, t0, fail_capa1
    bne s2, t0, fail_capa1
    bne s3, t0, fail_capa1
    j capa2_start

fail_capa1:
    li a0, 1
    j print_fail


    #   CAPA 2:
capa2_start:
    la t0, clave
    li s4, 0        
    li t1, 0        

capa2_block_loop:
    bge t1, s8, capa2_done


    li t2, 0        # acumulador suma
    mv t3, t0       # temporal
    li t4, 0        # contador interno

capa2_sum_loop:
    bge t4, s8, capa2_check
    lb t5, 0(t3)
    add t2, t2, t5
    addi t3, t3, 1
    addi t4, t4, 1
    j capa2_sum_loop

capa2_check:
    andi t6, t2, 1
    beqz t6, skip_block_ok
    addi s4, s4, 1     

skip_block_ok:
    addi t0, t0, 4     
    addi t1, t1, 1
    j capa2_block_loop

capa2_done:
    li t0, 3
    blt s4, t0, fail_capa2
    j capa3_start

fail_capa2:
    li a0, 2
    j print_fail


    #   CAPA 3: Hash
capa3_start:
    la t0, clave
    li t1, 0
    li s6, 0         

hash_loop:
    bge t1, s7, hash_done
    lb t2, 0(t0)

    mul s6, s6, s10       
    add s6, s6, t2        
    remu s6, s6, s9       

    addi t1, t1, 1
    addi t0, t0, 1
    j hash_loop

hash_done:
    ble s6, s11, fail_capa3   # hash debe ser > 10000
    j clave_ok                 

fail_capa3:
    li a0, 3
    j print_fail

    # --- CLAVE ACEPTADA ---
clave_ok:
    la a0, txt_ok
    li a7, 4
    ecall
    j end_program


    #   Impresion de fallo
print_fail:
    mv t6, a0

    la a0, txt_fail
    li a7, 4
    ecall

    mv a0, t6
    li a7, 1
    ecall

    la a0, newline
    li a7, 4
    ecall

end_program:
    li a7, 10
    ecall
