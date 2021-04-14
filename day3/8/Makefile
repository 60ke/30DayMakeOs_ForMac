MAKE = make -r
NASM = nasm
DEL = rm -f
default :
	$(MAKE) img

ipl10.bin : ipl10.nas
	$(NASM) ipl10.nas -o ipl10.bin -l ipl10.lst
sys : os.nas
	$(NASM) os.nas -o os.sys -l os.lst

img : ipl10.bin sys
	mformat -f 1440 -C -B ipl10.bin -i helloos.img ::
	mcopy -i helloos.img os.sys ::
run : img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a

clean :
	$(DEL) *.bin *.lst *.img *.sys
	