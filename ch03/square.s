.LC0:
        .string "input a, b, c: "
.LC1:
        .string "%f, %f, %f"
.LC3:
        .string "area = %f\n"
main:
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        addi    s0,sp,48

        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

# 取 a、b、c 地址
        addi    a3,s0,-36 # a3 = &c
        addi    a4,s0,-32
        addi    a5,s0,-28
        mv      a2,a4
        mv      a1,a5
        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    __isoc99_scanf

# 注意一下，下面的这些都是 float 寄存器
# float 需要 riscv 具有 F 拓展
        flw     fa4,-28(s0) # a
        flw     fa5,-32(s0) # b
        fadd.s  fa4,fa4,fa5 # fa4 = a + b
        flw     fa5,-36(s0)
        fadd.s  fa4,fa4,fa5 # fa4 = a + b + c
        lui     a5,%hi(.LC2)
        flw     fa5,%lo(.LC2)(a5)
        fdiv.s  fa5,fa4,fa5 # s = (a+b+c)/2
        fsw     fa5,-20(s0)

        flw     fa5,-28(s0) # a 
        flw     fa4,-20(s0) # s
        fsub.s  fa4,fa4,fa5 # s - a
        flw     fa5,-20(s0)
        fmul.s  fa4,fa4,fa5 # s * (s - a)
        flw     fa5,-32(s0)
        flw     fa3,-20(s0)
        fsub.s  fa5,fa3,fa5 # s - b
        fmul.s  fa4,fa4,fa5 # s * (s - a) * (s - b)
        flw     fa5,-36(s0)
        flw     fa3,-20(s0)
        fsub.s  fa5,fa3,fa5
        fmul.s  fa5,fa4,fa5 # s * (s - a) * (s - b) * (s - c)
        fcvt.d.s        fa5,fa5 # f_convert_double_single
        fmv.d   fa0,fa5
        call    sqrt

        fmv.d   fa5,fa0 # 获取 call 的结果
        fcvt.s.d        fa5,fa5 # double -> float
        fsw     fa5,-24(s0)

# printf
        flw     fa5,-24(s0)
        fcvt.d.s        fa5,fa5 # float -> double
        fmv.x.d a1,fa5 # f_move_integer_double
        lui     a5,%hi(.LC3)
        addi    a0,a5,%lo(.LC3)
        call    printf

# return
        li      a5,0
        mv      a0,a5
        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        jr      ra
.LC2:
        .word   1073741824 # 这个是 2.0f 的二进制表示
