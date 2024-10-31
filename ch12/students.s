/*

	这个结构体 sizeof == 48 ，还可以在一个寄存器中放下

	typedef struct date {
		int year;
		int month;
		int day;
	} DATE;

	typedef struct student {
		long studentID;
		char studentName[10];
		char studentSex;
		DATE birthday;
		int score[4];
	} STUDENT

	STUDENT changeSex(STUDENT stu)
	{
		STUDENT newStu = stu;
		newStu.studentSex = 10;
		return newStu;
	}

	int main(void) {
		STUDENT stu = {0};
		changeSex(stu);
		printf("%d", sizeof(STUDENT));  // 104
	}


*/


changeSex:                              # @changeSex
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48

	# 这里做的一件事情是：准备返回值
	
        sd      a1, -40(s0) # 对象的终止地址                     # 8-byte Folded Spill
        mv      a1, a0 
        ld      a0, -40(s0) # 对象的起始地址                     # 8-byte Folded Reload
        sd      a1, -24(s0)
        sd      a0, -32(s0)
        ld      a2, 40(a0) # stu.studentID
        sd      a2, 40(a1)
        ld      a2, 32(a0)
        sd      a2, 32(a1)
        ld      a2, 24(a0)
        sd      a2, 24(a1)
        ld      a2, 16(a0)
        sd      a2, 16(a1)
        ld      a2, 8(a0)
        sd      a2, 8(a1)
        ld      a0, 0(a0)
        sd      a0, 0(a1)

        li      a0, 10 # newStu.studentSex = 10
        sb      a0, 18(a1)

        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

main:                                   # @main
        addi    sp, sp, -176
        sd      ra, 168(sp)                     # 8-byte Folded Spill
        sd      s0, 160(sp)                     # 8-byte Folded Spill
        addi    s0, sp, 176

        li      a0, 0
        sd      a0, -168(s0)                    # 8-byte Folded Spill
        sd      a0, -24(s0)
        sd      a0, -32(s0)
        sd      a0, -40(s0)
        sd      a0, -48(s0)
        sd      a0, -56(s0)
        sd      a0, -64(s0)

		# 这中间还有 48 字节，存放的是 changeSex 的返回值
		# 也就是说明了这样一件事情：参数、返回值的内存，都是 caller 管理的

        ld      a0, -24(s0) # 这是将对象 复制了一遍，caller 进行的复制
        sd      a0, -120(s0)
        ld      a0, -32(s0)
        sd      a0, -128(s0)
        ld      a0, -40(s0)
        sd      a0, -136(s0)
        ld      a0, -48(s0)
        sd      a0, -144(s0)
        ld      a0, -56(s0)
        sd      a0, -152(s0)
        ld      a0, -64(s0)
        sd      a0, -160(s0)

        addi    a0, s0, -112 # 把对象的起始地址放到了这里
        addi    a1, s0, -160 # 对象的终止地址
        call    changeSex

.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        li      a1, 48
        call    printf

        ld      a0, -168(s0)                    # 8-byte Folded Reload
        ld      ra, 168(sp)                     # 8-byte Folded Reload
        ld      s0, 160(sp)                     # 8-byte Folded Reload
        addi    sp, sp, 176
        ret
.L.str:
        .asciz  "%d"

# 当然，上面这段代码只是在 寄存器 可以放得下整一个结构体的情况下，
# 下面我们来分析其他 寄存器存不下的情况。当然其实我觉得，好像这也与 寄存器无关了
