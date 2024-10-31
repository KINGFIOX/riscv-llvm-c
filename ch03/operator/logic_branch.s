.LC0:
	.string "Line 1 - \346\235\241\344\273\266\344\270\272\347\234\237"
.LC1:
	.string "Line 2 - \346\235\241\344\273\266\344\270\272\347\234\237"
.LC2:
	.string "Line 3 - \346\235\241\344\273\266\344\270\272\347\234\237"
.LC3:
	.string "Line 3 - \346\235\241\344\273\266\344\270\272\345\201\207"
.LC4:
	.string "Line 4 - \346\235\241\344\273\266\344\270\272\347\234\237"
main:
# 准备栈
	addi    sp,sp,-32
	sd      ra,24(sp)
	sd      s0,16(sp)
	addi    s0,sp,32

	li      a5,5 # int a = 5
	sw      a5,-20(s0)
	li      a5,20 # int b = 20
	sw      a5,-24(s0)

	lw      a5,-20(s0) # 取出 a ， 判断 a 是不是 0
	sext.w  a5,a5
	beq     a5,zero,.L2

	lw      a5,-24(s0) # 取出 b ，判断 b 是不是 0 ， 只有在 a!=0 的情况下才会到这里
	sext.w  a5,a5
	beq     a5,zero,.L2

# then
	lui     a5,%hi(.LC0)
	addi    a0,a5,%lo(.LC0)
	call    puts

.L2:
	lw      a5,-20(s0)
	sext.w  a5,a5
	bne     a5,zero,.L3 # a != 0 ? .L3

	lw      a5,-24(s0)
	sext.w  a5,a5
	beq     a5,zero,.L4 # a == 0 并且 b == 0 的时候才会走到这个跳转，否则都是到 .L3

.L3: # then
	lui     a5,%hi(.LC1)
	addi    a0,a5,%lo(.LC1)
	call    puts

.L4:
	sw      zero,-20(s0) # a = 0 

	li      a5,10 # b = 10
	sw      a5,-24(s0)

# if a != 0 && b != 0
	lw      a5,-20(s0)
	sext.w  a5,a5
	beq     a5,zero,.L5

	lw      a5,-24(s0)
	sext.w  a5,a5
	beq     a5,zero,.L5

# then
	lui     a5,%hi(.LC2)
	addi    a0,a5,%lo(.LC2)
	call    puts
	j       .L6

.L5: # else 
	lui     a5,%hi(.LC3)
	addi    a0,a5,%lo(.LC3)
	call    puts

.L6:
	lw      a5,-20(s0)
	sext.w  a5,a5
	beq     a5,zero,.L7 # a==0 ? .L7

	lw      a5,-24(s0)
	sext.w  a5,a5
	bne     a5,zero,.L8 # b!=0 ? .L8

.L7: # a==0 && b==0 then
	lui     a5,%hi(.LC4)
	addi    a0,a5,%lo(.LC4)
	call    puts

// 想一个事情，就是像这种 条件分支的语义，当我看到汇编的时候，我要怎么想到源代码长啥样
//
// 还有一个事情，就是我们这里是 puts，但是我源代码是 printf ，可能是编译器优化了

.L8: # !( a==0 && b==0 )
	li      a5,0
	mv      a0,a5

	ld      ra,24(sp)
	ld      s0,16(sp)
	addi    sp,sp,32
	jr      ra
