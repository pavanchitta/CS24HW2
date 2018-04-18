

.globl gcd
gcd:
    cmpl $0, %edi    # check if first arg = 0
    movl %esi, %eax  # move second arg into result
    je gcd_return    # if first arg = 0, return 2nd arg as gcd
    cmpl $0, %esi    # check if 2nd arg = 0
    movl  %edi, %eax # move 1st arg into result
    je gcd_return    # if 2nd arg = 0, return 1st arg as gcd
    movq $0, %rdx    # set %rdx = 0 to use idivl
    movq %rdi, %rax  # set %rax = 1st arg
    idivl %esi       # perform division 1st arg / 2nd arg, remainder in %rdx
    movl %esi, %edi  # move 2nd arg into %edi, to be first argument
    movq %rdx, %rsi  # move Rem into %rsi, to be second argument
    call gcd         # recursive call

gcd_return:
    ret   # All done
