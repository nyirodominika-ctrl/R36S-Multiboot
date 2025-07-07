#!/bin/bash

export EZSDevPart=$(blkid |grep EZSTORAGE |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)

sed -i 's|system.automount=1|system.automount=0|' /storage/.config/system/configs/system.cfg

if [[ ! -f /storage/.config/udev.rules.d/95-udevil-mount.rules ]]
then
        cp /usr/lib/udev/rules.d/95-udevil-mount.rules /storage/.config/udev.rules.d/95-udevil-mount.rules
        sed -i 's/IMPORT{builtin}="blkid"/IMPORT{builtin}="blkid"\nENV{ID_FS_LABEL}=="ezstorage|EZSTORAGE|EZStorage|amberelec|ark|pan4elec|rocknix|uos|bookworm|jammy|noble|plucky|amberboot|arkboot|pan4boot|rocknoot|uosboot|bookwormboot|bookboot|jammyboot|nobleboot|pluckyboot|armbian", GOTO="exit"/' /storage/.config/udev.rules.d/95-udevil-mount.rules
        udevadm control --reload-rules && udevadm trigger
fi

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

[[ ! -d /storage/EZSTORAGE ]] && mkdir /storage/EZSTORAGE
mount -t vfat -o umask=000,noatime ${EZSDevPart} /storage/EZSTORAGE

mount -o rw,remount /flash
mkdir -p /flash/u-boot
mount -o ro ${EZSDev}p1 /flash/u-boot
mount -o ro,remount /flash