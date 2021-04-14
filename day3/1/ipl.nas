;ipl inital program loader
;hello-os
;TAB=4
	ORG     0x7c00          ;ORG origin缩写,源头起点,0x7c00 系统引导区的装载地址被规定为0x00007C00--0x00007DFF,https://wiki.osdev.org/Memory_Map_(x86)
;fat12格式软盘
    JMP     entry           ;JMP jump缩写,跳转,entry 入口
	DB	    0x90            ;暂不知道为什么要为0x90，DB为Define Byte缩写,8 Byte
	DB	    "HELLOIPL"      ;启动扇区名字可以自由写
	DW	    512             ;一扇区(sector)大小固定为512，DW为define word缩写16 Byte
	DB	    1               ;簇(cluster)大小,必须为一个扇区
	DW	    1               ;FAT的起始位置一般从第一个扇区开始
	DB	    2               ;FAT的数量必须为2
	DW	    224             ;根目录大大小(一般设置我224)
	DW	    2880            ;该磁盘的扇区数目(软盘1.4M / 512byte)
	DB	    0xf0            ;磁盘的种类(必须是0xf0)
	DW	    9               ;FAT的长度(必须是9扇区)
	DW	    18              ;一个磁道(track)有多少个扇区(必须为18)
	DW      2				;磁头数必须是2
	DD	    0               ;不使用分区必须是0,DD Define Double Word缩写32 BYTE
	DD	    2880            ;重写一次磁盘大小
	DB	    0,0,0x29        ;意义不明,固定
	DD	    0xffffffff      ;(可能是)卷标
	DB	    "HELLO-OS   "   ;磁盘的名称(11Byte)
	DB	    "FAT12   "      ;磁盘格式名称(8Byte)
	TIMES	18	DB	0       ;同 RESB 18空出18字节
;程序主体
entry:
    MOV     AX,0            ;初始化寄存器,MOV move缩写,赋值语句,AX——accumulator，累加寄存器
    MOV     SS,AX           ;SS——栈段寄存器（stack segment)
    MOV     SP,0x7c00       ;对应上面的ORG地址,SP——stack pointer，栈指针寄存器
    MOV     DS,AX           ;DS——数据段寄存器（data segment)
;读磁盘
    MOV     AX,0x820
    MOV     ES,AX           ;ES——附加段寄存器（extra segment)
    MOV     CH,0            ;柱面0
    MOV     DH,0            ;磁头0
    MOV     CL,2            ;扇区2

    MOV     AH,0x02         ;AH=0x02:读盘
    MOV     AL,1            ;一个扇区
    MOV     BX,0
    MOV     DL,0x00         ;A驱动器
    INT     0x13            ;调用磁盘bios
    JC      error           ;JC:jump if carry

fin:
    HLT                     ;让CPU停止,等待指令
    JMP     fin             ;无限循环


error:
    MOV     SI,msg          ;SI——source index，源变址寄存器
;信息显示部分
putloop:;循环
    MOV     AL,[SI]         ;[SI]表示的是SI的值,在这里即为内存地址
    ADD     SI,1
    CMP     AL,0            ;CMP compare缩写比较,AL的值是否为0(字符串结尾)
    JE      fin             ;JE jump if equal缩写,如果相等就跳转,fin finish缩写
    MOV     AH,0x0e         ;显示一个文字,AH——累加寄存器高位（accumulator high）
    MOV     BX,15           ;指定字符颜色,BX——base，基址寄存器
    INT     0x10            ;调用显卡BIOS,INT interrupt缩写中断指令,https://en.wikipedia.org/wiki/INT_13H
    JMP     putloop

msg:
	DB	    0x0a, 0x0a      ;2个换行
	DB	    "load error"
	DB	    0x0a
	DB	    0               ;同C语言,以0判断字符串结束标志
	TIMES   0x1fe-($-$$) DB 0        ;填写0x00,直到0x001fe
	DB	    0x55, 0xaa		;规定第一扇区最后两个字节为0x55, 0xaa,认定这个扇区开头为启动程序,并开始执行这个程序
