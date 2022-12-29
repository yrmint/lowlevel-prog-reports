  # setup
.text
__start:
.globl __start
  call   main
finish:
  mv     a1, a0            # a1 = a0
  li     a0, 17            # a0 = 17
  ecall                    # выход с кодом завершения
  
  
  # main
.text
main:
.globl main
  addi   sp, sp, -16       # выделение памяти в стеке
  sw     ra, 12(sp)        # сохранение в ra
  
  la     a0, array
  lw     a1, array_length
  call   max
  mv     a2, a0
  
  li     a0, 4             # a0 = 4 ecall code to print string
  la     a1, string        # a1 = index of string
  ecall                    # print string

  li     a0, 23            # a0 = 24 ecall code to print int
  mv     a1, a2            # a1 = a2
  ecall                    # print int from a1
  
  lw     ra, 12(sp)        # воссстановление ra
  addi   sp, sp, 16        # освобождение памяти в стеке
  
  li     a0, 0             # a0 = 0
  ret
  
.rodata
array_length:
  .word 11
array:
  .word 4, 60, 15, 10, 25, 100, 413, 0, 9, 512, 513
string:
  .ascii "Max value: "
  .word 0
 
 
  # max
.text
max:
.globl max
  # в a0 – адрес 0-го элемента массива чисел типа unsigned
  # в a1 – длина массива
  
  slli   a7, a1, 2         # a7 = a1 * 4
  add    a7, a0, a7        # end_ptr
  lw     a2, 0(a0)         # a2 - максимальный элемент (сначала - первый)
  beq    a0, a7, exit      # if( array_ptr == end_ptr ) goto exit
  
loop:
  lw     t0 0(a0)          # t0 = * array_ptr
  addi   a0, a0, 4         # array_ptr += 1
  bgeu   a2, t0, skip      # if (a2 >= t0) goto skip
  mv     a2, t0            # a2 = t0
  
skip:
  bne    a0, a7, loop      # if( array_ptr != end_ptr ) goto loop
 
exit:
  mv     a0, a2
  ret