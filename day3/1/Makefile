MAKE = make -r
NASM = nasm
DEL = rm -f
default :
	$(MAKE) img

ipl.bin : ipl.nas
	$(NASM) ipl.nas -o ipl.bin -l ipl.lst


img : ipl.bin
	mformat -f 1440 -C -B ipl.bin -i helloos.img ::

run : img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a

clean :
	$(DEL) *.bin *.lst *.img
	