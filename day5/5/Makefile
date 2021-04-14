MAKE = make -r
NASM = nasm
DEL = rm -f
CAT = cat
default :
	$(MAKE) img


txt2fontc : txt2font.c
	gcc txt2font.c -o txt2fontc

hankaku.c : hankaku.txt txt2fontc
	./txt2fontc


ipl10.bin : ipl10.nas
	$(NASM) ipl10.nas -o ipl10.bin -l ipl10.lst

asmhead.bin : asmhead.nas
	$(NASM) asmhead.nas -o asmhead.bin -l asmhead.lst

naskfunc.o : naskfunc.nas Makefile          # naskfunc.nas创建二进制文件
	$(NASM) -g -f elf naskfunc.nas -o naskfunc.o -l naskfunc.lst

bootpack.hrb : naskfunc.o bootpack.c hankaku.c hrb.ld       # 使用脚本编译C文件
	i386-elf-gcc -march=i486 -m32 -nostdlib -T hrb.ld -g bootpack.c hankaku.c naskfunc.o -o bootpack.hrb
# i386-elf-gcc -T script
        #    Use script as the linker script.  This option is supported by most
        #    systems using the GNU linker.

sys : asmhead.bin bootpack.hrb
	$(CAT) asmhead.bin bootpack.hrb > os.sys

img : ipl10.bin sys
	mformat -f 1440 -C -B ipl10.bin -i helloos.img ::
	mcopy -i helloos.img os.sys ::
run : img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a

clean :
	$(DEL) *.bin *.lst *.img *.sys *.hrb *.o hankaku.c txt2fontc
	