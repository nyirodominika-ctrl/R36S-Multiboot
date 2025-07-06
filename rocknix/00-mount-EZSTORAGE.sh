#!/bin/bash

export EZSDevPart=$(blkid |grep EZSTORAGE |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)


sed -i 's|system.automount=1|system.automount=0|' /storage/.config/system/configs/system.cfg


for i in /storage/games-external/roms /storage/games-external /storage/games-internal/roms /storage/games-internal /storage/roms
do
        while :
        do
                mount |grep "$i" >/dev/null 2>&1 || break
                umount $i 2>&1
        done
done

for i in $(find /var/media/*)
do
        while :
        do
                mount |grep "$i" >/dev/null 2>&1 || break
                umount $i 2>&1
        done
done

[[ ! -d /storage/EZSTORAGE ]] && mkdir /storage/EZSTORAGE
mount -t vfat -o umask=000,noatime ${EZSDevPart} /storage/EZSTORAGE

mount -o rw,remount /flash
mkdir -p /flash/u-boot
mount -o ro ${EZSDev}p1 /flash/u-boot
mount -o ro,remount /flash