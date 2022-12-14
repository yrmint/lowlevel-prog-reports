# Вариант 12 - Определение максимального значения в массиве элементов без знака
# Результат работы программы в a5 + выводится в консоль
# t0 - текущее число
# a2 - длина массива
# a3 - адрес первого элемента массива
# a4 - адрес i
# a5 - текущий результат
# a6 - счетчик loop

.text
__start:
.globl __start
  lw     a2, array_length  # a2 = <длина массива> 
  la     a3, array         # установка регистра a3 в значение адреса, соответствующего метке array
  li     a6, 0             # a6 = 0 
  lw     a5, 0(a3)         # a5 - текущий результат (сначала - первый элемент массива)
 
loop:
  bgeu   a6, a2, exit      # if (a6 >= a2) goto exit
  slli   a4, a6, 2         # a4 = a6 << 2 = a6 * 4
  add    a4, a3, a4        # a4 = a3 + a4 = a3 + a6 * 4 = i
  lw     t0, 0(a4)         # t0 = array[i]
  addi   a6, a6, 1         # i += 1
  bgeu   a5, t0, skip      # if (a5 >= t0) goto skip
  mv     a5, t0            # a5 = t0
  
skip:

  jal    zero, loop        # goto loop
 
exit:

finish:

  li     a0, 4             # a0 = 4 ecall code to print string
  la     a1, string        # a1 = index of string
  ecall                    # print string

  li     a0, 24            # a0 = 24 ecall code to print int
  mv     a1, a5            # a1 = a5
  ecall                    # print int from a1
 
  li     a0, 10            # a0 = 10 
  ecall                    # ecall при значении a0 = 10 => останов симулятора 

.rodata
array_length:
    .word 10
array:
    .word 4, 60, 15, 10, 25, 100, 413, 0, 9, 12
string:
    .ascii "Max value: "
    .word 0