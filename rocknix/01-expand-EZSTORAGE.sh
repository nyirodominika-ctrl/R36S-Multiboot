#!/bin/bash
[[ -f /storage/EZSTORAGE/.uglystuff/storagewasexpanded ]] && notExpanded=0 || notExpanded=1

export EZSDevPart=$(blkid |grep EZSTORAGE |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)
echo EZSTORAGE partition device is ${EZSDevPart};echo EZSTORAGE device is ${EZSDev} ;echo EZSTORAGE partition number is ${EZSPartNum}

if [ $notExpanded -eq 1 ]
then
    umount /storage/EZSTORAGE
    sync
    sleep 2
    parted --script --fix ${EZSDev} resizepart ${EZSPartNum} 100%
    sync
    sleep 2
    mkfs.fat -F32 -v -I -n EZSTORAGE ${EZSDevPart}
    sync
    sleep 2
    fsck.fat -a ${EZSDevPart}
    mount -t vfat -o umask=000,noatime ${EZSDevPart} /storage/EZSTORAGE
    mkdir -p /storage/EZSTORAGE/.uglystuff
    touch /storage/EZSTORAGE/.uglystuff/storagewasexpanded
fi
