fib:
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        sd      s1,24(sp) # 先把 s1 保护起来
        addi    s0,sp,48
        mv      a5,a0 # 保存参数
        sw      a5,-36(s0)

		# if (n == 0) 
        lw      a5,-36(s0) # 将参数加载到 a5
        sext.w  a5,a5
        bne     a5,zero,.L2

        li      a5,0
        j       .L3

.L2: # if (n == 1)
        lw      a5,-36(s0)
        sext.w  a4,a5
        li      a5,1
        bne     a4,a5,.L4

        li      a5,1
        j       .L3

.L4: # n != 0 也 n != 1 递归情况
        lw      a5,-36(s0)
        addiw   a5,a5,-1
        sext.w  a5,a5
        mv      a0,a5
        call    fib # s1 = fib(n-1)
        mv      s1,a0

        lw      a5,-36(s0)
        addiw   a5,a5,-2
        sext.w  a5,a5
        mv      a0,a5
        call    fib # fib(n-2)

        mv      a5,a0
        add     a5,s1,a5

# 递归情况会使用到 s1 寄存器保存第一个 fib(n-1) 的结果
# 为什么不使用 t 呢？
# 因为我们在调用完 t1 = fib(n-1) 之后，还会调用 fib(n-2)，
# 其中 fib(n-2) 不知道会不会修改 t1 的值，
# s 之类的寄存器，他的语义就是：调用一个函数过后，调用者看不到 s 类寄存器的变化
# 这个太神奇了，riscv 与 生命周期

.L3: # 结果放到 a0 ，退栈，函数返回
        mv      a0,a5
        ld      ra,40(sp)
        ld      s0,32(sp)
        ld      s1,24(sp)  # 将保存的 s1 恢复
        addi    sp,sp,48
        jr      ra
.LC0:
        .string "f(20) = %ld\n"
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

		// f:i64 = fib(20); f 在 -24 这个位置
        li      a0,20
        call    fib
        sd      a0,-24(s0)
        ld      a1,-24(s0)
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra

