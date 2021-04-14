MAKE	= make -r

img:
	nasm helloos.nas -o helloos.img
run:
	MAKE img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a
clean:
	rm *.img