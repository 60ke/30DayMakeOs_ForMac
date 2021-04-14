void io_hlt(void);
// void write_mem8(int addr, int data);
void HariMain(void)
{
	int i;
	char *p; /*变量p存byte类型*/
	for(i = 0xa0000;i<=0xaffff;i++){
		p = (char*) i;
		*p = i & 0x0f;
		// write_mem8(i,i&0x0f); //&(AND)与都为真时为true
	}
	for(;;){
		io_hlt();
	}
}
