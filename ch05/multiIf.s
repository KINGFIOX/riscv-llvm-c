.LC0:
        .string "%d %d %d"
.LC1:
        .string "\347\255\211\350\276\271"
.LC2:
        .string "\347\255\211\350\205\260"
.LC3:
        .string "\347\233\264\350\247\222"
.LC4:
        .string "\344\270\200\350\210\254"
.LC5:
        .string "\344\270\211\350\247\222\345\275\242"
.LC6:
        .string "\344\270\215\346\230\257\344\270\211\350\247\222\345\275\242"
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

# scanf
        addi    a3,s0,-32
        addi    a4,s0,-28
        addi    a5,s0,-24
        mv      a2,a4
        mv      a1,a5
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    __isoc99_scanf

        lw      a4,-24(s0)
        lw      a5,-28(s0)
        addw    a5,a4,a5
        sext.w  a4,a5
        lw      a5,-32(s0)
        bleu    a4,a5,.L2 # branch less equal unsigned

# 他那个 bleu 有点类似于 栅栏的东西，你拦住了，就不能下来了

        lw      a4,-28(s0)
        lw      a5,-32(s0)
        addw    a5,a4,a5
        sext.w  a4,a5
        lw      a5,-24(s0)
        bleu    a4,a5,.L2

        lw      a4,-24(s0)
        lw      a5,-32(s0)
        addw    a5,a4,a5
        sext.w  a4,a5
        lw      a5,-28(s0)
        bleu    a4,a5,.L2

        li      a5,1
        sb      a5,-17(s0) # sb: 在 -17(s0) 位置上存储一个字节，这个存储的就是 flag

        lw      a4,-24(s0)
        lw      a5,-28(s0)
        bne     a4,a5,.L3 # 拦路虎，拦住不相等的
        lw      a4,-28(s0)
        lw      a5,-32(s0)
        bne     a4,a5,.L3
        lw      a4,-32(s0)
        lw      a5,-24(s0)
        bne     a4,a5,.L3

# printf 等边三角形
        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    printf

# 清除 flag
        sb      zero,-17(s0)
        j       .L4
.L3:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        beq     a4,a5,.L5
        lw      a4,-28(s0)
        lw      a5,-32(s0)
        beq     a4,a5,.L5
        lw      a4,-32(s0)
        lw      a5,-24(s0)
        bne     a4,a5,.L4
.L5:
        lui     a5,%hi(.LC2)
        addi    a0,a5,%lo(.LC2)
        call    printf
        sb      zero,-17(s0)

.L4: # 判断是否是 直角三角形
        lw      a4,-24(s0)
        lw      a5,-24(s0)
        mulw    a5,a4,a5 # a^2
        sext.w  a4,a5
        lw      a3,-28(s0)
        lw      a5,-28(s0)
        mulw    a5,a3,a5 # b^2
        sext.w  a5,a5
        addw    a5,a4,a5 # a^2 + b^2
        sext.w  a4,a5
        lw      a3,-32(s0)
        lw      a5,-32(s0)
        mulw    a5,a3,a5
        sext.w  a5,a5
        beq     a4,a5,.L6 # a^2 + b^2 == c^2

        lw      a4,-24(s0)
        lw      a5,-24(s0)
        mulw    a5,a4,a5
        sext.w  a4,a5
        lw      a3,-32(s0)
        lw      a5,-32(s0)
        mulw    a5,a3,a5
        sext.w  a5,a5
        addw    a5,a4,a5
        sext.w  a4,a5
        lw      a3,-28(s0)
        lw      a5,-28(s0)
        mulw    a5,a3,a5
        sext.w  a5,a5
        beq     a4,a5,.L6

        lw      a4,-28(s0)
        lw      a5,-28(s0)
        mulw    a5,a4,a5
        sext.w  a4,a5
        lw      a3,-32(s0)
        lw      a5,-32(s0)
        mulw    a5,a3,a5
        sext.w  a5,a5
        addw    a5,a4,a5
        sext.w  a4,a5
        lw      a3,-24(s0)
        lw      a5,-24(s0)
        mulw    a5,a3,a5
        sext.w  a5,a5

        bne     a4,a5,.L7

# 如果 b^2 + c^2 == a^2 ，那么程序就会 fall 下来

.L6: # 直角三角形
        lui     a5,%hi(.LC3)
        addi    a0,a5,%lo(.LC3)
        call    printf
        sb      zero,-17(s0)

.L7:
        lbu     a5,-17(s0) # load byte unsigned
        andi    a5,a5,0xff # flag | 1  看看是不是 0
        beq     a5,zero,.L8
        lui     a5,%hi(.LC4) # 如果是 flag==0 ，那么就会架空这几行代码
        addi    a0,a5,%lo(.LC4)
        call    printf

.L8:
        lui     a5,%hi(.LC5)
        addi    a0,a5,%lo(.LC5)
        call    puts
        j       .L9

.L2:
        lui     a5,%hi(.LC6)
        addi    a0,a5,%lo(.LC6)
        call    puts

.L9: # return 0 }
        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
