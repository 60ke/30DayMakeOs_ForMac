MAKE = make -r
ipl.bin : ipl.nas
	nasm ipl.nas -o ipl.bin -l ipl.lst
helloos.img : ipl.bin
	mformat -f 1440 -C -B ipl.bin -i helloos.img ::
img :
	MAKE helloos.img
run :
	MAKE img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a
clean :
	rm *.bin
	rm *.lst
	rm *.img