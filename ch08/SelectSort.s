.LCPI0_0: 
        .quad   -6640827866535438581            # 0xa3d70a3d70a3d70b

# void genRandArr(int arr[], size_t n) {
genRandArr:                             # @genRandArr
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48

        sd      a0, -24(s0) # score
        sd      a1, -32(s0) # n

# 循环开始 int i = 0;
        li      a0, 0
        sd      a0, -40(s0)
        j       .LBB0_1
.LBB0_1: # 循环条件 i < n - 1                             # =>This Inner Loop Header: Depth=1
        ld      a0, -40(s0)
        ld      a1, -32(s0)
        bgeu    a0, a1, .LBB0_4 # 这里是：是否跳到 else
        j       .LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        call    random
.Lpcrel_hi0:
        auipc   a1, %pcrel_hi(.LCPI0_0) 
        addi    a1, a1, %pcrel_lo(.Lpcrel_hi0)
        ld      a1, 0(a1)
        mulh    a1, a0, a1
        add     a1, a1, a0
        srli    a2, a1, 63
        srli    a1, a1, 6
        addw    a1, a1, a2
        li      a2, 100
        mulw    a1, a1, a2
        subw    a0, a0, a1
# 这里是 random() % 100 ，但是我感觉真tmd神奇

        ld      a1, -24(s0) # 基址 score
        ld      a2, -40(s0) # i
        slli    a2, a2, 2 # sizeof(int) == 4
        add     a1, a1, a2
        sw      a0, 0(a1) # 存储
        j       .LBB0_3
.LBB0_3: # i++                                #   in Loop: Header=BB0_1 Depth=1
        ld      a0, -40(s0)
        addi    a0, a0, 1
        sd      a0, -40(s0)
        j       .LBB0_1
.LBB0_4: # } 结束
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

# 打印数组
printArr:                               # @printArr
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48
        sd      a0, -24(s0) # arr
        sd      a1, -32(s0) # n

        li      a0, 91
        call    putchar
		
# for ( int i = 0;
        li      a0, 0
        sd      a0, -40(s0)
        j       .LBB1_1
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
# ; i < n ;
        ld      a0, -40(s0)
        ld      a1, -32(s0)
        addi    a1, a1, -1
        bgeu    a0, a1, .LBB1_4
        j       .LBB1_2
.LBB1_2:                                #   in Loop: Header=BB1_1 Depth=1
        ld      a0, -24(s0) # arr
        ld      a1, -40(s0) # i
        slli    a1, a1, 2 # i * 4
        add     a0, a0, a1 # arr + i*4
        lw      a1, 0(a0)
.Lpcrel_hi1:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi1)
        call    printf
        j       .LBB1_3
.LBB1_3:                                #   in Loop: Header=BB1_1 Depth=1
# i++ ) {
        ld      a0, -40(s0)
        addi    a0, a0, 1
        sd      a0, -40(s0)
        j       .LBB1_1
.LBB1_4: # printf("%d]\n", arr[n - 1]);
        ld      a1, -24(s0) # arr
        ld      a0, -32(s0) # n
        slli    a0, a0, 2
        add     a0, a0, a1
        lw      a1, -4(a0) # arr + (n-1)*4
.Lpcrel_hi2:
        auipc   a0, %pcrel_hi(.L.str.1)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi2)
        call    printf

        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

# 交换 swap(int arr[], size_t i, size_t j)
swap:                                   # @swap
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48
        sd      a0, -24(s0) # arr
        sd      a1, -32(s0) # i
        sd      a2, -40(s0) # j

        ld      a0, -24(s0)
        ld      a1, -32(s0)
        slli    a1, a1, 2
        add     a0, a0, a1 # arr + i*4
        lw      a0, 0(a0)
        sw      a0, -44(s0) # tmp = arr[i]

        ld      a1, -24(s0)
        ld      a0, -40(s0)
        slli    a0, a0, 2
        add     a0, a0, a1
        lw      a0, 0(a0) # arr[j]
        ld      a2, -32(s0) # i
        slli    a2, a2, 2
        add     a1, a1, a2 # arr + i*4
        sw      a0, 0(a1)

        lw      a0, -44(s0) # tmp
        ld      a1, -24(s0)
        ld      a2, -40(s0)
        slli    a2, a2, 2
        add     a1, a1, a2
        sw      a0, 0(a1) # arr[j] = tmp

        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

# 选择排序 sort(int arr[], size_t n)
sort:                                   # @sort
        addi    sp, sp, -64
        sd      ra, 56(sp)                      # 8-byte Folded Spill
        sd      s0, 48(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 64
        sd      a0, -24(s0) # arr
        sd      a1, -32(s0) # n

	# for(int i = 0;
        li      a0, 0
        sd      a0, -40(s0)
        j       .LBB3_1
.LBB3_1:                                # =>This Loop Header: Depth=1
	# ; i < n; 
        ld      a0, -40(s0)
        ld      a1, -32(s0)
        bgeu    a0, a1, .LBB3_10 
        j       .LBB3_2
.LBB3_2:                                #   in Loop: Header=BB3_1 Depth=1
        lui     a0, 524288 # 读取 INT_MAx 最大值，但是感觉这显然不是最大的
        addiw   a0, a0, -1
        sw      a0, -44(s0) # min - 524288 - 1
        ld      a0, -40(s0)
        sd      a0, -56(s0) # min_index = i
        ld      a0, -40(s0)
        sd      a0, -64(s0) # j = i
        j       .LBB3_3
.LBB3_3: # ; j < n                                #   Parent Loop BB3_1 Depth=1
        ld      a0, -64(s0)
        ld      a1, -32(s0)
        bgeu    a0, a1, .LBB3_8
        j       .LBB3_4
.LBB3_4:                                #   in Loop: Header=BB3_3 Depth=2
        lw      a1, -44(s0)
        ld      a0, -24(s0)
        ld      a2, -64(s0)
        slli    a2, a2, 2
        add     a0, a0, a2
        lw      a0, 0(a0) # arr[j]
        bge     a0, a1, .LBB3_6 # arr[j] >= min
        j       .LBB3_5
.LBB3_5:                                #   in Loop: Header=BB3_3 Depth=2
        ld      a0, -24(s0)
        ld      a1, -64(s0)
        slli    a1, a1, 2
        add     a0, a0, a1
        lw      a0, 0(a0) # arr[j]
        sw      a0, -44(s0) # min = arr[j]
        ld      a0, -64(s0) 
        sd      a0, -56(s0) # min = j
        j       .LBB3_6
.LBB3_6:                                #   in Loop: Header=BB3_3 Depth=2
        j       .LBB3_7
.LBB3_7:      # j++                          #   in Loop: Header=BB3_3 Depth=2
        ld      a0, -64(s0)
        addi    a0, a0, 1
        sd      a0, -64(s0)
        j       .LBB3_3
.LBB3_8:                                #   in Loop: Header=BB3_1 Depth=1
        ld      a0, -24(s0)
        ld      a1, -40(s0)
        ld      a2, -56(s0)
        call    swap

        ld      a0, -24(s0)
        ld      a1, -32(s0)
        call    printArr

        j       .LBB3_9
.LBB3_9: # i++                                #   in Loop: Header=BB3_1 Depth=1
        ld      a0, -40(s0)
        addi    a0, a0, 1
        sd      a0, -40(s0)
        j       .LBB3_1
.LBB3_10:
	# return 
        ld      ra, 56(sp)                      # 8-byte Folded Reload
        ld      s0, 48(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 64
        ret

main:                                   # @main
        addi    sp, sp, -80
        sd      ra, 72(sp)                      # 8-byte Folded Spill
        sd      s0, 64(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 80

        li      a0, 10
        sd      a0, -24(s0)
        ld      a1, -24(s0)
        addi    a0, s0, -64
        sd      a0, -72(s0)                     # 8-byte Folded Spill
        call    genRandArr

        ld      a0, -72(s0)                     # 8-byte Folded Reload
        ld      a1, -24(s0)
        call    printArr

        ld      a0, -72(s0)                     # 8-byte Folded Reload
        ld      a1, -24(s0)
        call    sort

        ld      a0, -72(s0)                     # 8-byte Folded Reload
        ld      a1, -24(s0)
        call    printArr

        li      a0, 0
        ld      ra, 72(sp)                      # 8-byte Folded Reload
        ld      s0, 64(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 80
        ret
.L.str:
        .asciz  "%d, "

.L.str.1:
        .asciz  "%d]\n"
