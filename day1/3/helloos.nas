;hello-os
;TAB=4
	;ORG     0x7c00          ;系统引导区的装载地址被规定为0x00007C00--0x00007DFF,https://wiki.osdev.org/Memory_Map_(x86)
;fat12格式软盘
	DB	    0xeb, 0x4e, 0x90            ;暂不知道为什么要为0x90，DB为Define Byte缩写,8 Byte
	DB	    "HELLOIPL"      ;启动扇区名字可以自由写
	DW	    512             ;一扇区(sector)大小固定为512，DW为define word缩写16 Byte
	DB	    1               ;簇(cluster)大小,必须为一个扇区
	DW	    1               ;FAT的起始位置一般从第一个扇区开始
	DB	    2               ;FAT的数量必须为2
	DW	    224             ;根目录大大小(一般设置我224)
	DW	    2880            ;该磁盘的扇区数目(软盘1.4M / 512byte)
	DB	    0xf0           ;磁盘的种类(必须是0xf0)
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
	DB	    0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
	DB	    0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
	DB	    0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
	DB	    0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
	DB	    0xee, 0xf4, 0xeb, 0xfd
;信息显示部分

	DB	    0x0a, 0x0a      ;2个换行
	DB	    "hello, world"
	DB	    0x0a
	DB	    0               ;同C语言,以0判断字符串结束标志
	TIMES   0x1fe-($-$$) DB 0        ;填写0x00,直到0x001fe
	DB	    0x55, 0xaa		;规定第一扇区最后两个字节为0x55, 0xaa,认定这个扇区开头为启动程序,并开始执行这个程序
;以下是启动区以外部分的输出
	DB	    0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
	TIMES	4600 DB 0
	DB	    0Xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
	TIMES	1469432 DB 0
;题外话
;启动…………… （boot）boot这个词本是长靴（boots）的单数形式。
;它与计算机的启动有什么关系呢？一般应该将启动称为start的。实
;际上，boot这个词是bootstrap的缩写，原指靴子上附带的便于拿
;取的靴带。但自从有了《吹牛大王历险记》（德国）这个故事以后，
;bootstrap这个词就有了“自力更生完成任务”这种意思”
;摘录来自: 川合秀实. “30天自制操作系统。” Apple Books. 