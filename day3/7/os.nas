;TAB=4
	ORG		0xc200						;内存装载位置
	MOV		AL,0x13						;VGA显卡,320✖️200✖️8位彩色
	MOV		AH,0x00
	INT		0x10

fin:
		HLT
		JMP		fin