/*

typedef struct date {
    int year;
    int month;
    int day;
} DATE;

typedef struct student {
    long studentID;
    char studentName[32];
    char studentSex;
    DATE birthday;
    int score[4];
} STUDENT;

STUDENT changeSex(STUDENT stu)
{
    STUDENT newStu = stu;
    newStu.studentSex = 10;
    return newStu;
}

int main(void) {
    STUDENT stu = {0};
    changeSex(stu);
    printf("%d", sizeof(STUDENT));  // 72
}


这个结构体大小是 72

 */

# 汇编上是：(返回地址, 形参地址)
changeSex:                              # @changeSex
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48
        sd      a0, -40(s0)                     # 8-byte Folded Spill
        sd      a0, -24(s0)
        sd      a1, -32(s0)

		# memcpy(dest=返回, src=形参, n=72)
        li      a2, 72
        call    memcpy # 再大一些的结构体，就是使用了 memcpy

        ld      a1, -40(s0)                     # 8-byte Folded Reload
        li      a0, 10
        sb      a0, 40(a1) # stu.sex = 10

	# 返回
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret
main:                                   # @main
        addi    sp, sp, -272
        sd      ra, 264(sp)                     # 8-byte Folded Spill
        sd      s0, 256(sp)                     # 8-byte Folded Spill
        addi    s0, sp, 272

		# a0 = -88 ；a1 = 0 ；a2 = 72 memset(-88, 0, 72)，也就是将 -88 ~ -16 位置设置为 0
        addi    a0, s0, -88
        sd      a0, -272(s0)                    # 8-byte Folded Spill
        li      a1, 0
        sd      a1, -248(s0)                    # 8-byte Folded Spill
        li      a2, 72
        sd      a2, -256(s0)                    # 8-byte Folded Spill
        call    memset

        ld      a1, -272(s0)                    # 8-byte Folded Reload
        ld      a2, -256(s0)                    # 8-byte Folded Reload

		// int a = 10;
        li      a0, 10
        sw      a0, -92(s0)

		# a1 = -88 ；a2 = 72 ；a0 = -168 memcpy(dest=-168, src=-88, n=72)
		# 这里是将 实参 拷贝到 形参
        addi    a0, s0, -168
        sd      a0, -264(s0)                    # 8-byte Folded Spill
        call    memcpy

		# changeSex(-240, -168) 这里 -160 是 返回值对象的起始地址，-232 是形参的起始地址
		ld      a1, -264(s0)                    # 8-byte Folded Reload
        addi    a0, s0, -240
        call    changeSex(student)

        ld      a1, -256(s0)                    # 8-byte Folded Reload
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        call    printf

        ld      a0, -248(s0)                    # 8-byte Folded Reload
        ld      ra, 264(sp)                     # 8-byte Folded Reload
        ld      s0, 256(sp)                     # 8-byte Folded Reload
        addi    sp, sp, 272
        ret
.L.str:
        .asciz  "%d"
