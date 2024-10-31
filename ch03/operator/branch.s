.LC0:
	.string "Line 1 - a \347\255\211\344\272\216 b"
.LC1:
	.string "Line 1 - a \344\270\215\347\255\211\344\272\216 b"
.LC2:
	.string "Line 2 - a \345\260\217\344\272\216 b"
.LC3:
	.string "Line 2 - a \344\270\215\345\260\217\344\272\216 b"
.LC4:
	.string "Line 3 - a \345\244\247\344\272\216 b"
.LC5:
	.string "Line 3 - a \344\270\215\345\244\247\344\272\216 b"
.LC6:
	.string "Line 4 - a \345\260\217\344\272\216\346\210\226\347\255\211\344\272\216 b"
.LC7:
	.string "Line 5 - b \345\244\247\344\272\216\346\210\226\347\255\211\344\272\216 a"
main:
# int main {
	addi    sp,sp,-32
	sd      ra,24(sp)
	sd      s0,16(sp)
	addi    s0,sp,32

# int a = 21
	li      a5,21
	sw      a5,-20(s0)

# int b = 10
	li      a5,10
	sw      a5,-24(s0)

# if (a == b)
	lw      a5,-20(s0)                                                                  # a5 = a
	mv      a4,a5
	lw      a5,-24(s0)                                                                  # a4 = b
	sext.w  a4,a4
	sext.w  a5,a5
	bne     a4,a5,.L2

# then { printf("Line 1 - a 不等于 b"); }
	lui     a5,%hi(.LC0)
	addi    a0,a5,%lo(.LC0)
	call    puts
	j       .L3                                                                         # 跳过下面的 .L3 分支，也就是 else 分支

.L2: # else { printf("Line 1 - a 不等于 b\n"); }
	lui     a5,%hi(.LC1)
	addi    a0,a5,%lo(.LC1)
	call    puts

.L3:
	lw      a5,-20(s0)                                                                  # a5 = a
	mv      a4,a5
	lw      a5,-24(s0)                                                                  # a4 = b
	sext.w  a4,a4
	sext.w  a5,a5
	bge     a4,a5,.L4                                                                   # 但是其实可以看到

# then { printf }
	lui     a5,%hi(.LC2)
	addi    a0,a5,%lo(.LC2)
	call    puts
	j       .L5

# else { printf }
.L4:
	lui     a5,%hi(.LC3)
	addi    a0,a5,%lo(.LC3)
	call    puts

# if ( a > b )
.L5:
	lw      a5,-20(s0)                                                                  # a
	mv      a4,a5
	lw      a5,-24(s0)                                                                  # b
	sext.w  a4,a4
	sext.w  a5,a5
	ble     a4,a5,.L6

# then
	lui     a5,%hi(.LC4)
	addi    a0,a5,%lo(.LC4)
	call    puts
	j       .L7

# else
.L6:
	lui     a5,%hi(.LC5)
	addi    a0,a5,%lo(.LC5)
	call    puts
.L7:
	li      a5,5                                                                        # a = 5
	sw      a5,-20(s0)
	li      a5,20                                                                       # b = 20
	sw      a5,-24(s0)

# if ( a <= b )
	lw      a5,-20(s0) // 读取 a 、b
	mv      a4,a5
	lw      a5,-24(s0)
	sext.w  a4,a4
	sext.w  a5,a5
	bgt     a4,a5,.L8

# then
	lui     a5,%hi(.LC6)
	addi    a0,a5,%lo(.LC6)
	call    puts
# if ( a >= b )
.L8:
	lw      a5,-24(s0)
	mv      a4,a5
	lw      a5,-20(s0)
	sext.w  a4,a4
	sext.w  a5,a5
	blt     a4,a5,.L9
# then
	lui     a5,%hi(.LC7)
	addi    a0,a5,%lo(.LC7)
	call    puts
.L9:
# } 下面是 return 了

	li      a5,0
	mv      a0,a5
	ld      ra,24(sp)
	ld      s0,16(sp)
	addi    sp,sp,32
	jr      ra

# 发现一个很有趣的现象，就是在跳转分支的时候，他正好会做一个 逻辑取反 的操作，
# 如果是 then 的话，那么会无视 jump 指令，下落执行
# 如果是 else 的话，那么就会进入到 jump 指令指向的分支
