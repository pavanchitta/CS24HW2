/* This file contains x86-64 assembly-language implementations of three
 * basic, very common math operations.
 *
 * All these operations avoid the use of branching statements in their
 * functioning. There are no conditional statements that may branch to
 * different lines based on a condition evaluated at run time.
 *
 * Each of these three functions essentially has to use an if statement
 * to check a condition, and in a naive approach we would use jmp operations
 * based on what value an input takes on at run time. jmp also has two
 * operations, checking the condition and jumping, and this extra operation is
 * costly. Using jmp would also force the processor to use branch
 * prediction and this can be costly if it is gotten wrong, which can happen a
 * lot if there is no way to predict the condition accurately. Processors need
 * to be able to determine the sequence of instructions
 * to be executed beforehand so they can make the most use of pipelining.
 * This becomes hard with branch prediction. On the other hand, if we use
 * conditional moves, we evaluate both the if and else statements beforehand,
 * which allows optimal use of pipelining, and then it finally
 * uses a conditional move statement. The processor can actually execute
 * conditional moves without having to predict the outcome first, since it can
 * just check flags, so we can eliminate the penalty of wrong branch
 * prediction.
 */

 /* In all of these problems, we only have to use the lower 32-bit portions of
  * the registers because we are dealing with ints, but we don't have to worry
  * about setting the upper 32 bits to zero because this is done by the
  * assembler.
  */


        .text

/*====================================================================
 * This function takes two integers as arguments and returns the smaller
 * value. If equal, returns the common value. This is a min function.
 *
 * int f1(int x, int y)
 */
.globl f1
f1:
        movl    %edi, %edx    # Set %edx = x (%edi holds 1st arg).
        movl    %esi, %eax    # Set %eax = %esi = y.
        cmpl    %edx, %eax    # Set sign flag according to %eax - %edx, which
                              # corresponds to y - x.
        cmovg   %edx, %eax    # Set %eax = x if x < y, based on sign flag.
        ret                   # Result is in %eax.


/*====================================================================
 * This function takes an input x, and returns the absolute
 * value of the number. If the number is non-negative, the sign bit is
 * 0, and thus the right shift by 31 will leave 0 in %edx. XOR'ing with x
 * will give x back and then we subtract 0 from x to retain x in %eax.
 * If x < 0, then the sign bit is 1, and right shifting by 31 will give
 * all 1's and thus represents -1.Then the XOR will invert the
 * number bitwise and this will give us (-x - 1). Then we do the subtraction
 * (-x - 1) -(-1) = -x. Thus it multiplies x by (-1), and returns that positive
 * value.
 *
 * int f2(int x)
 */
.globl f2
f2:
        movl    %edi, %eax   # Set %eax = %edi = x.
        movl    %eax, %edx   # Set %edx = x.
        sarl    $31, %edx    # Set %edx = %edx >> 31 (arithmetic). This sets
                             # %edx to all ones if x < 0, all 0's otherwise.
        xorl    %edx, %eax   # Set %eax = %eax XOR %edx. maintains x if x >= 0,
                             # otherwise bitwise invert.
        subl    %edx, %eax   # Set %eax = %eax - %edx. %edx = 0 if x >= 0,
                             # -1 otherwise.
        ret                  # Result is in %eax.


/*====================================================================
 * This function checks whether a number is negative, zero or positive.
 * If it is negative it returns -1. If it is positive, it returns 1. If it is
 * zero, it returns 0. First we set %edx = x and %eax = x.Then we right shift
 * %eax 31 times (arithmetic), so if x < 0, then %eax = -1, otherwise 0.
 * Then we update flags for operation x & x. Then set %edx = 1. If x > 0,
 * sign flag will be zero and ZF != 0 (since result will be x), so it will
 * set %eax = 1. If x < 0, SF = 1, so wont set anything and %eax = -1. If
 * x = 0, ZF = 0, and nothing will be set and %eax = 0.
 *
 * int f3(int x)
 */
.globl f3
f3:
        movl    %edi, %edx   # Set %edx = %edi = x.
        movl    %edx, %eax   # Set %eax = %edx = x.
        sarl    $31, %eax    # Set eax = -1 (two's complement) if x < 0,
                             # 0 otherwise.
        testl   %edx, %edx   # Update flags for %edx & %edx = x & x
        movl    $1, %edx     # Set %edx = 1
        cmovg   %edx, %eax   # if ~(SF ^ 0F) & ~ZF, set %eax = %edx = 1
        ret                  # Result is in %eax.
