#!/bin/bash
[[ -f /storage/EZSTORAGE/.DontModify/storagewasexpanded ]] && notExpanded=0 || notExpanded=1
[[ $notExpanded -eq 1 ]] && touch /storage/expanding.EZSTORAGE
export EZSDevPart=$(blkid |grep EZSTORAGE |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)
echo EZSTORAGE partition device is ${EZSDevPart};echo EZSTORAGE device is ${EZSDev} ;echo EZSTORAGE partition number is ${EZSPartNum}

if [ $notExpanded -eq 1 ]
then
    if [[ ! -f /storage/.config/udev.rules.d/95-udevil-mount.rules ]]
    then
        cp /usr/lib/udev/rules.d/95-udevil-mount.rules /storage/.config/udev.rules.d/95-udevil-mount.rules
        sed -i 's/IMPORT{builtin}="blkid"/IMPORT{builtin}="blkid"\nENV{ID_FS_LABEL}=="ezstorage|EZSTORAGE|EZStorage|amberelec|ark|pan4elec|rocknix|uos|bookworm|jammy|noble|plucky|amberboot|arkboot|pan4boot|rocknoot|uosboot|bookwormboot|bookboot|jammyboot|nobleboot|pluckyboot|armbian", GOTO="exit"/' /storage/.config/udev.rules.d/95-udevil-mount.rules
    fi
    echo "  Expanding EZSTORAGE... Device will restart..." >>/dev/tty1
    umount /storage/EZSTORAGE
    sync
    sleep 2
    echo -e "resizepart\n2\nYes\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} > /storage/resizeEpart.log 2>&1
    sync
    sleep 2
    echo -e "resizepart\n2\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} >> /storage/resizeEpart.log 2>&1
    sync
    sleep 2
    echo -e "resizepart\n${EZSPartNum}\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} >> /storage/resizeEpart.log 2>&1
    sync
    sleep 2
    echo -e "resizepart\n${EZSPartNum}\nYes\n100%\nprint\nquit" | parted ---pretend-input-tty ${EZSDev} >> /storage/resizeEpart.log 2>&1
    sync
    sleep 2
    mkfs.fat -F32 -v -I -n EZSTORAGE ${EZSDevPart}
    sync
    sleep 2
    fsck.fat -a ${EZSDevPart}
    sync
    sleep 2
    fsck.fat -a ${EZSDev}p1
    sync
    sleep 2
    mount -t vfat -o umask=000,noatime ${EZSDevPart} /storage/EZSTORAGE
    mkdir -p /storage/EZSTORAGE/.DontModify
    touch /storage/EZSTORAGE/.DontModify/storagewasexpanded
    sync
    # mount --bind /storage/games-internal /storage/games-external
    # mount --bind /storage/games-external/roms /storage/roms
    # /bin/bash /flash/u-boot/setup-ezstorage.sh rocknix /storage/games-internal/roms /storage/EZSTORAGE > /storage/setup-ezstorage.log 2>&1
    sync
    sleep 5
    rm /storage/expanding.EZSTORAGE
    reboot
    sleep 600
    exit 1
fi

[[ -f /storage/expanding.EZSTORAGE ]] && rm /storage/expanding.EZSTORAGE || true