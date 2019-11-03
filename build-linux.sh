
if test "`whoami`" != "root" ; then
	echo "Debe ingresar como usuario raiz"
	echo "Ingrese 'su' o 'sudo bash' para cambiar a raiz"
	exit
fi


if [ ! -e disk_images/manjaro.flp ]
then
	echo ">>> Creando nueva imagen floppy"
	mkdosfs -C disk_images/manjaro.flp 1440 || exit
fi


echo ">>> Ensamblando bootloader..."

nasm -O0 -w+orphan-labels -f bin -o source/bootload/bootload.bin source/bootload/bootload.asm || exit


echo ">>> Ensamblando kernel..."

cd source
nasm -O0 -w+orphan-labels -f bin -o kernel.bin kernel.asm || exit
cd ..


echo ">>> Ensamblando programas..."

cd programs

for i in *.asm
do
	nasm -O0 -w+orphan-labels -f bin $i -o `basename $i .asm`.bin || exit
done

cd ..


echo ">>> Agregando bootloader a floppy..."

dd status=noxfer conv=notrunc if=source/bootload/bootload.bin of=disk_images/manjaro.flp || exit


echo ">>> Copiando kernel y programas..."

rm -rf tmp-loop

mkdir tmp-loop && mount -o loop -t vfat disk_images/manjaro.flp tmp-loop && cp source/kernel.bin tmp-loop/

cp programs/*.bin programs/*.bas programs/sample.pcx tmp-loop

sleep 0.2

echo ">>> Desmontando floppy..."

umount tmp-loop || exit

rm -rf tmp-loop


echo ">>> Creando ISO..."

rm -f disk_images/manjaro.iso
mkisofs -quiet -V 'MANJARO' -input-charset iso8859-1 -o disk_images/manjaro.iso -b manjaro.flp disk_images/ || exit

echo '>>> Terminado'

