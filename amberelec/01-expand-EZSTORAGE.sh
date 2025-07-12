#!/bin/bash
[[ -f /storage/EZSTORAGE/.DontModify/storagewasexpanded ]] && notExpanded=0 || notExpanded=1
[[ $notExpanded -eq 1 ]] && touch /storage/expanding.EZSTORAGE
export EZSDevPart=$(blkid |grep EZSTORAGE | grep -v EZSTORAGE2 |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)
echo EZSTORAGE partition device is ${EZSDevPart};echo EZSTORAGE device is ${EZSDev} ;echo EZSTORAGE partition number is ${EZSPartNum}

OsName=$(for i in $(cat /proc/cmdline); do [[ "$i" == "disk=LABEL="* ]] && (echo $i|cut -d'=' -f3); [[ "$i" == "disk=LABEL="* ]] && break; done)

if [[ "$OsName" == "rocknix" ]] || [[ "$OsName" == "uos" ]]
then
    ttySpacing="\r\033[K\r==> "
    ttyEndChar="\r"
else
    ttySpacing="  "
    ttyEndChar="\n"
fi

if [ $notExpanded -eq 1 ]
then
    echo -ne "${ttySpacing}Expanding EZSTORAGE... Device will restart...$ttyEndChar" >>/dev/tty1
    umount /storage/EZSTORAGE
    sync
    echo -e "resizepart\n2\nYes\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} > /storage/resizeEpart.log 2>&1
    echo -e "resizepart\n2\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} >> /storage/resizeEpart.log 2>&1
    sync
    echo -e "resizepart\n${EZSPartNum}\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} >> /storage/resizeEpart.log 2>&1
    echo -e "resizepart\n${EZSPartNum}\nYes\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} >> /storage/resizeEpart.log 2>&1
    sync
    mkfs.exfat -n EZSTORAGE ${EZSDevPart} >> /storage/resizeEpart.log 2>&1
    sync
    fsck.exfat -y ${EZSDevPart} >> /storage/resizeEpart.log 2>&1
    sync
    fsck.fat -y ${EZSDev}p1 >> /storage/resizeEpart.log 2>&1
    sync
    mount -t exfat -o umask=000,noatime ${EZSDevPart} /storage/EZSTORAGE >> /storage/resizeEpart.log 2>&1
    mkdir -p /storage/EZSTORAGE/.DontModify
    touch /storage/EZSTORAGE/.DontModify/storagewasexpanded
    sync
    sleep 3
    rm /storage/expanding.EZSTORAGE
    reboot
    reboot -f
    reboot --force

    sleep 600
    exit 1
fi

[[ -f /storage/expanding.EZSTORAGE ]] && rm /storage/expanding.EZSTORAGE || true