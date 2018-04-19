

.globl gcd

# Because we are using ints, we are using the low 32 bits if the registers,
# and that's why we use edi, edx, etc. The upper 32 bits are automatically
# cleared.

gcd:
        cmpl    $0, %esi        # Check if 2nd arg = 0 (only have to check
                                # second arg because it is smaller)
        movl    %edi, %eax      # Move 1st arg into result
        je      gcd_return      # If 2nd arg = 0, return 1st arg as
                                # gcd --- base case

        movl    $0, %edx        # Set %edx = 0 to set up for use in idivl
        movl    %edi, %eax      # Set %eax = 1st arg for use in idivl
        idivl   %esi            # Perform division 1st arg / 2nd arg, leaving
                                # remainder in %rdx.
        movl    %esi, %edi      # Move 2nd arg into %edi, to be first argument
        movl    %edx, %esi      # Move remainder into %esi, to be second
                                # argument.
        call    gcd             # Make recursive call, with old 2nd arg as
                                # new 1st arg and remainder as 2nd arg.
gcd_return:
        ret                     # All done, result in %eax.
