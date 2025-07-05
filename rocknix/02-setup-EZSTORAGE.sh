#!/bin/bash

OsName=$(for i in $(cat /proc/cmdline); do [[ "$i" == "disk=LABEL="* ]] && (echo $i|cut -d'=' -f3 ; break); done)

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
