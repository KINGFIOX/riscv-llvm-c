fib:                                    # @fib
        addi    sp, sp, -64
        sd      ra, 56(sp)                      # 8-byte Folded Spill
        sd      s0, 48(sp) # 
        addi    s0, sp, 64
        sw      a0, -20(s0)

		// 这里看起来有些复杂，实际上是 为了得到 (n+1)*8
        lw      a0, -20(s0)
        addiw   a0, a0, 1  # n+1
		slli    a1, a0, 32  # 左移 32 ，再右移 32，是为了消除 高32 位
		srli    a0, a1, 32 
			mv      a2, sp # 将原来 sp 的位置保存到 -32(s0) 位置
			sd      a2, -32(s0)
        srli    a1, a1, 29 # (a1 << 32) >> 29，相当于消除了 高32位后，再乘以了 8，得到 (n+1)*8

		// 这里是将 某个 (n+1)*8 向上取整到最接近 16的倍数，用于内存对齐
		addi    a1, a1, 15 
		andi    a2, a1, -16 

# 调整 sp 指针
        mv      a1, sp
        sub     a1, a1, a2
        sd      a1, -56(s0)                     # 8-byte Folded Spill
        mv      sp, a1 # 调整 sp 指针，因为有变长数组
        sd      a0, -40(s0)

# 其实可以看到，这个比较有趣的就是，这个数组是向上生长的
        li      a0, 0
        sd      a0, 0(a1) # arr[0]
        li      a0, 1
        sd      a0, 8(a1)

        li      a0, 2 # i = 2
        sw      a0, -44(s0)
        j       .LBB0_1  # 我的想法，这还用跳嘛？直接落下来就行了吧。但是：与 PIC

.LBB0_1: # 循环条件This Inner Loop Header: Depth=1
        lw      a1, -44(s0)
        lw      a0, -20(s0)
        blt     a0, a1, .LBB0_4

        j       .LBB0_2

.LBB0_2:
        ld      a1, -56(s0) # 得到 arr 的 基址                     # 8-byte Folded Reload
        lw      a2, -44(s0) # a2 = i
        addiw   a0, a2, -1  # i-1，以为 arr[i] = arr[i-1] + arr[i-2]
        slli    a0, a0, 3
        add     a0, a0, a1
        ld      a0, 0(a0) # a0 = arr[i-1]

        addiw   a3, a2, -2
        slli    a3, a3, 3
        add     a3, a3, a1
        ld      a3, 0(a3) # a3 = arr[i-2]

        add     a0, a0, a3 # a0 = arr[i-1] + arr[i-2]

        slli    a2, a2, 3 # 
        add     a1, a1, a2
        sd      a0, 0(a1)

        j       .LBB0_3

.LBB0_3: # for( i++ )                               #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -44(s0)
        addiw   a0, a0, 1
        sw      a0, -44(s0)
        j       .LBB0_1

.LBB0_4:
        ld      a0, -56(s0) # a0 = 基址                   # 8-byte Folded Reload
        lw      a1, -20(s0) # a1 = n
        slli    a1, a1, 3
        add     a0, a0, a1
        ld      a0, 0(a0) # 获取返回值

        ld      a1, -32(s0) # a1 = 调整前的栈顶
        mv      sp, a1
        addi    sp, s0, -64
        ld      ra, 56(sp)                      # 8-byte Folded Reload
        ld      s0, 48(sp) # 恢复                     # 8-byte Folded Reload
        addi    sp, sp, 64
        ret

main:                                   # @main
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48
        li      a0, 0
        sd      a0, -40(s0)                     # 8-byte Folded Spill
        sw      a0, -20(s0)
        li      a0, 20
        call    fib

        sd      a0, -32(s0)
        ld      a1, -32(s0)

.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        call    printf

        ld      a0, -40(s0)                     # 8-byte Folded Reload
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret
.L.str:
        .asciz  "f(20) = %ld\n"

.Ldebug_list_header_start0:
        .half   5                               # Version
        .byte   8                               # Address size
        .byte   0                               # Segment selector size
        .word   1                               # Offset entry count
        .word   .Ldebug_loc0 - .Lloclists_table_base0 # 计算两个标签之间的差异，并将这个差距作为一个字的值
        .byte   4                               # DW_LLE_offset_pair
        .byte   2                               # Loc expr size
        .byte   123                             # DW_OP_breg11
        .byte   0                               # 0
        .byte   4                               # DW_LLE_offset_pair
        .byte   3                               # Loc expr size
        .byte   120                             # DW_OP_breg8
        .byte   72                              # -56
        .byte   6                               # DW_OP_deref
        .byte   0                               # DW_LLE_end_of_list
.Ldebug_list_header_end0:

# 上面这个是 clang 生成版，感觉比 gcc 要复杂一些
# 而且确实会有许多不同的：gcc 喜欢操作 a5
