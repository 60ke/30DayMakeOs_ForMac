void io_hlt(void);
void io_cli(void);
void io_out8(int port,int data);
int io_load_eflags(void);
int io_store_eflags(int eflags);
void init_palette(void);		//初始化调色板
void set_palette(int start,int end,unsigned char*rgb);		//设置调色板
// void write_mem8(int addr, int data);


void HariMain(void)
{
	int i;
	char *p; /*变量p存byte类型*/
	init_palette();
	p = (char*) 0xa0000;
	for(i = 0x0000;i<=0xffff;i++){
		*(p+i) = i & 0x0f;
		// write_mem8(i,i&0x0f); //&(AND)与都为真时为true
	}
	for(;;){
		io_hlt();
	}
}

void init_palette(void){
	static unsigned char table_rgb[16 * 3] = {
		0x00, 0x00, 0x00,		/*  0:黑 */
		0xff, 0x00, 0x00,		/*  1:亮红 */
		0x00, 0xff, 0x00,		/*  2:亮绿 */
		0xff, 0xff, 0x00,		/*  3:亮黄 */
		0x00, 0x00, 0xff,		/*  4:亮蓝 */
		0xff, 0x00, 0xff,		/*  5:亮紫 */
		0x00, 0xff, 0xff,		/*  6:浅亮蓝 */
		0xff, 0xff, 0xff,		/*  7:白 */
		0xc6, 0xc6, 0xc6,		/*  8:亮灰 */
		0x84, 0x00, 0x00,		/*  9:暗红 */
		0x00, 0x84, 0x00,		/* 10:暗绿 */
		0x84, 0x84, 0x00,		/* 11:暗黄 */
		0x00, 0x00, 0x84,		/* 12:暗青 */
		0x84, 0x00, 0x84,		/* 13:暗紫 */
		0x00, 0x84, 0x84,		/* 14:浅暗蓝 */
		0x84, 0x84, 0x84,		/* 15:暗灰 */
	};
	set_palette(0,15,table_rgb);
	return;
		
}

void set_palette(int start,int end,unsigned char* rgb){
	int i,eflags;
	eflags = io_load_eflags();		//记录中断许可标志的值
	io_cli();		//将中断许可标志设置为0,禁止中断
	io_out8(0x03c8,start);
	for (i = start;i <= end; i++){
		io_out8(0x03c9,rgb[0]/4);
		io_out8(0x03c9,rgb[1]/4);
		io_out8(0x03c9,rgb[2]/4);
		rgb += 3;
	}
	io_store_eflags(eflags);		//复原中断许可标志
	return;
}