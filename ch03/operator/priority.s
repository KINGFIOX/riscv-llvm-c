.LC0:
        .string "(a + b) * c / d \347\232\204\345\200\274\346\230\257 %d\n"
main:
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        addi    s0,sp,48 # 4 * (a/b/c/d/e) + 8 + 8 = 36，然后取整就是 48


        li      a5,20 # a = 20
        sw      a5,-20(s0)
        li      a5,10 # b = 10
        sw      a5,-24(s0)
        li      a5,15 # c = 15
        sw      a5,-28(s0)
        li      a5,5 # d = 5
        sw      a5,-32(s0)

# e = (a + b) * c / d
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-24(s0)
        addw    a5,a4,a5 # a5 = a + b
        sext.w  a5,a5
        lw      a4,-28(s0) # woc，终于看到 lw 到 a4 的了。但是还可以看到，就是把一些计算的中间结果还是放到了 a5 中
        mulw    a5,a4,a5
        sext.w  a5,a5
        lw      a4,-32(s0)
        divw    a5,a5,a4
        sw      a5,-36(s0)
        lw      a5,-36(s0)

        mv      a1,a5
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

# return 0 }
        li      a5,0
        mv      a0,a5
        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        jr      ra
