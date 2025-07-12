#!/bin/bash
sleep 1
while [[ -f /storage/expanding.EZSTORAGE ]]
do
    sleep 4
done

OsName=$(for i in $(cat /proc/cmdline); do [[ "$i" == "disk=LABEL="* ]] && (echo $i|cut -d'=' -f3); [[ "$i" == "disk=LABEL="* ]] && break; done)

if [[ "$OsName" == "rocknix" ]] || [[ "$OsName" == "uos" ]]
then
    ttySpacing="\r\033[K\r==> "
    ttyEndChar="\r"
else
    ttySpacing="  "
    ttyEndChar="\n"
fi

[[ -L /storage/roms ]] && rm -f /storage/roms

if grep /storage/EZSTORAGE2 /proc/mounts
then
    echo -ne "${ttySpacing}Setting up EZSTORAGE2$ttyEndChar" >>/dev/tty1
    /bin/bash /flash/u-boot/setup-ezstorage.sh $OsName /storage/roms /storage/EZSTORAGE2 > /storage/setup-ezstorage.log 2>&1
else
    echo -ne "${ttySpacing}Setting up EZSTORAGE$ttyEndChar" >>/dev/tty1
    /bin/bash /flash/u-boot/setup-ezstorage.sh $OsName /storage/roms /storage/EZSTORAGE > /storage/setup-ezstorage.log 2>&1
fi


