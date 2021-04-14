MAKE = make -r
NASM = nasm
DEL = rm -f
default :
	$(MAKE) img

ipl.bin : ipl.nas
	$(NASM) ipl.nas -o ipl.bin -l ipl.lst
sys : os.nas
	$(NASM) os.nas -o os.sys -l os.lst

img : ipl.bin sys
	mformat -f 1440 -C -B ipl.bin -i helloos.img ::
	mcopy -i helloos.img os.sys ::
run : img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a

clean :
	$(DEL) *.bin *.lst *.img *.sys
	