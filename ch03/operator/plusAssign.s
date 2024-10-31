.LC0:
        .string "Line 1 - =  \350\277\220\347\256\227\347\254\246\345\256\236\344\276\213\357\274\214c \347\232\204\345\200\274 = %d\n"
.LC1:
        .string "Line 2 - += \350\277\220\347\256\227\347\254\246\345\256\236\344\276\213\357\274\214c \347\232\204\345\200\274 = %d\n"
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

        li      a5,21 # a = 21
        sw      a5,-20(s0)
        lw      a5,-20(s0) # c = a 
        sw      a5,-24(s0)

        lw      a5,-24(s0) # a4 = c
        mv      a4,a5
        lw      a5,-20(s0) # a5 = a
        addw    a5,a4,a5 # a5 = a4 + a5
        sw      a5,-24(s0)

# call printf
        lw      a5,-24(s0)
        mv      a1,a5
        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    printf

# return 0;
        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
