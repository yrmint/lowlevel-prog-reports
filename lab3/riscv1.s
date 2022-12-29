# Вариант 12 - Определение максимального значения в массиве чисел без знака
# Результат работы программы в a6 + выводится в консоль
# t0 - текущее число
# a3 - длина массива
# a4 - адрес первого элемента массива
# a5 - адрес i
# a6 - текущий результат
# a7 - счетчик loop

.text
__start:
.globl __start
  lw     a3, array_length  # a3 = <длина массива> 
  la     a4, array         # установка регистра a3 в значение адреса, соответствующего метке array
  li     a7, 0             # a7 = 0 
  lw     a6, 0(a4)         # a6 - текущий результат (сначала - первый элемент массива)
 
loop:
  bgeu   a7, a3, exit      # if (a7 >= a3) goto exit
  slli   a5, a7, 2         # a5 = a7 << 2 = a7 * 4
  add    a5, a4, a5        # a5 = a4 + a5 = a4 + a7 * 4 = i
  lw     t0, 0(a5)         # t0 = array[i]
  addi   a7, a7, 1         # i += 1
  bgeu   a6, t0, skip      # if (a6 >= t0) goto skip
  mv     a6, t0            # a6 = t0
  
skip:

  jal    zero, loop        # goto loop
 
exit:

finish:

  li     a0, 4             # a0 = 4 ecall code to print string
  la     a1, string        # a1 = index of string
  ecall                    # print string

  li     a0, 24            # a0 = 24 ecall code to print int
  mv     a1, a6            # a1 = a6
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