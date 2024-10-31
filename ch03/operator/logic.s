main: # int main {
	addi   sp,sp,-32
	sd     ra,24(sp)
	sd     s0,16(sp)
	addi   s0,sp,32

	li     a5,5 # a = 5
	sw     a5,-20(s0)

	li     a5,20 # b = 20
	sw     a5,-24(s0)

	lw     a5,-20(s0) # 取出 a
	sext.w a5,a5
	beq    a5,zero,.L2 # a==0 ? .L2

	lw     a5,-24(s0) # 说明 a != 0
	sext.w a5,a5
	beq    a5,zero,.L2

	li     a5,1 # 能走到这里，说明 a!=0 && b!=0
	j      .L3

.L2:
	li     a5,0

.L3:
	sw     a5,-28(s0)

# return 0; }
	li     a5,0
	mv     a0,a5
	ld     ra,24(sp)
	ld     s0,16(sp)
	addi   sp,sp,32
	jr     ra

# 说明一件事情，就是 riscv 汇编在实现 与或非 的时候，是通过分支来处理的
