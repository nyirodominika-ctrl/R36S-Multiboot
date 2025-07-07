#!/bin/bash
sleep 1
while [[ -f /storage/expanding.EZSTORAGE ]]
do
    sleep 4
done
echo "  Setting up EZSTORAGE folders and mounts..." >>/dev/tty1
OsName=$(for i in $(cat /proc/cmdline); do [[ "$i" == "disk=LABEL="* ]] && (echo $i|cut -d'=' -f3); [[ "$i" == "disk=LABEL="* ]] && break; done)

[[ -L /storage/roms ]] && rm -f /storage/roms

if [[ "$OsName" == "rocknix" ]] || [[ "$OsName" == "uos" ]]
then
    mount --bind /storage/games-internal /storage/games-external
    mount --bind /storage/games-external/roms /storage/roms
    /bin/bash /flash/u-boot/setup-ezstorage.sh $OsName /storage/games-internal/roms /storage/EZSTORAGE
fi

if [[ "$OsName" == "amberelec" ]] || [[ "$OsName" == "pan4elec" ]]
then
    /bin/bash /flash/u-boot/setup-ezstorage.sh $OsName /storage/roms /storage/EZSTORAGE
fi
