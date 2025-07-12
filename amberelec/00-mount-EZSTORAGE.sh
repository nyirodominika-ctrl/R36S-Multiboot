#!/bin/bash

IntDev=$(mount |grep "/flash "| cut -d' ' -f1 | cut -dp -f1)
export EZSDevPart=$(blkid |grep EZSTORAGE | grep $IntDev |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)


OsName=$(for i in $(cat /proc/cmdline); do [[ "$i" == "disk=LABEL="* ]] && (echo $i|cut -d'=' -f3); [[ "$i" == "disk=LABEL="* ]] && break; done)

if [[ "$OsName" == "rocknix" ]] || [[ "$OsName" == "uos" ]]
then
    ttySpacing="\r\033[K\r==> "
    ttyEndChar="\r"
else
    ttySpacing="  "
    ttyEndChar="\n"
fi
echo -ne "${ttySpacing}Mounting EZSTORAGE...$ttyEndChar" >>/dev/tty1

sed -i 's|system.automount=1|system.automount=0|' /storage/.config/system/configs/system.cfg

while :
do
        for i in /storage/games-external/roms /storage/games-external /storage/games-internal/roms /storage/games-internal /storage/roms /storage/roms2
        do
                mount |grep "$i" >/dev/null 2>&1 || break
                umount $i 2>&1
        done

        for j in $(find /var/media -type d -mindepth 1 -maxdepth 1)
        do
                mount |grep "$j" >/dev/null 2>&1 || break
                umount $j 2>&1
        done

        for k in /storage/games-external/roms /storage/games-external /storage/games-internal/roms /storage/games-internal /storage/roms /storage/roms2
        do
                mount | grep "$k" >/dev/null 2>&1 && continue
        done

        mount | grep "/var/media" >/dev/null 2>&1 && continue

        break
done
/bin/bash /flash/u-boot/umount-ez.sh

[[ ! -d /storage/EZSTORAGE ]] && mkdir /storage/EZSTORAGE
mount -t exfat -o umask=000,noatime ${EZSDevPart} /storage/EZSTORAGE || exit 1

[[ $IntDev == "/dev/mmcblk0" ]] && ExtDev=/dev/mmcblk1
[[ $IntDev == "/dev/mmcblk1" ]] && ExtDev=/dev/mmcblk0

export EZSTwoDevPart=$(blkid |grep EZSTORAGE2 | grep $ExtDev |cut -d: -f1)

if [[ -n "$EZSTwoDevPart" ]]
then
        export EZSTwoPartNum=$(echo ${EZSTwoDevPart} | cut -dp -f2)
        export EZSTwoDev=$(echo ${EZSTwoDevPart} | cut -dp -f1)
        [[ ! -d /storage/EZSTORAGE2 ]] && mkdir /storage/EZSTORAGE2
        mount -t exfat -o umask=000,noatime ${EZSTwoDevPart} /storage/EZSTORAGE2 || exit 1
fi

mount -o rw,remount /flash
mkdir -p /flash/u-boot
mount -o ro ${EZSDev}p1 /flash/u-boot
mount -o ro,remount /flash