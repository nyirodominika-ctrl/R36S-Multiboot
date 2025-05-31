#!/bin/bash

# [[ -f "ROCKNIX-RK3326.aarch64-latest-a.img" ]] && rm ROCKNIX-RK3326.aarch64-latest-a.img
# [[ -f "ArkOS_R35S-R36S.img" ]] && rm ArkOS_R35S-R36S.img
# [[ -f "armbian.img" ]] && rm armbian.img

supportedpanel=false
if [[ ! -z "$1" ]]
then
    for thispanel in 1 2 3 4 4-60hz 5-soy 5-Soy
    do
        [[ "$thispanel" == "$1" ]] && supportedpanel=true
    done
    [[ ! "$supportedpanel" == "true" ]] && exit 1
    panel=$1
else
    panel=4-60hz
fi

if [[ ! -f "ROCKNIX-RK3326.aarch64-latest-a.img" ]]
then
    [[ -f "ROCKNIX-RK3326.aarch64-latest-a.img.gz" ]] && rm ROCKNIX-RK3326.aarch64-latest-a.img.gz
    [[ -f "ROCKNIX-RK3326.aarch64-latest-a.img" ]] && rm ROCKNIX-RK3326.aarch64-latest-a.img
    ROCKNIXdl=$(lynx -listonly -dump -nonumbers "https://github.com/ROCKNIX/distribution/releases/latest" |grep "ROCKNIX-RK3326.aarch64-.*-a.img.gz" 2>/dev/null)
    echo $ROCKNIXdl
    wget -OROCKNIX-RK3326.aarch64-latest-a.img.gz "$ROCKNIXdl"
    gunzip ROCKNIX-RK3326.aarch64-latest-a.img.gz
fi


if [[ ! -f "ArkOS_R35S-R36S.img" ]]
then
    ArkOSdl=https://github.com/AeolusUX/ArkOS-R3XS/releases/download/ArkOS.V2.0.4302025/ArkOS_R35S-R36S_v2.0_04302025.img.7z
    [[ -f "ArkOS_R35S-R36S.img.7z.001" ]] && rm ArkOS_R35S-R36S.img.7z.001
    [[ -f "ArkOS_R35S-R36S.img.7z" ]] && rm ArkOS_R35S-R36S.img.7z
    [[ -f "ArkOS_R35S-R36S.img" ]] && rm ArkOS_R35S-R36S.img
    ArkOSdl1=${ArkOSdl}.001
    echo $ArkOSdl1
    wget -OArkOS_R35S-R36S.img.7z.001 "$ArkOSdl1"

    [[ -f "ArkOS_R35S-R36S.img.7z.002" ]] && rm ArkOS_R35S-R36S.img.7z.002
    ArkOSdl2=${ArkOSdl}.002
    echo $ArkOSdl2
    wget -OArkOS_R35S-R36S.img.7z.002 "$ArkOSdl2"
    7z x ArkOS_R35S-R36S.img.7z.001
    rm ArkOS_R35S-R36S.img.7z.001 ArkOS_R35S-R36S.img.7z.002
    sync
    arkImg=$(find . |grep "ArkOS_R35S-R36S")
    unxz --decompress $arkImg
    arkImg=$(find . |grep "ArkOS_R35S-R36S")
    mv ${arkImg} ArkOS_R35S-R36S.img
fi


if [[ ! -f "armbian.img" ]]
then
    [[ -f "armbian.img.xz" ]] && rm armbian.img.xz
    armbiandl=https://dl.armbian.com/uefi-arm64/Noble_current_xfce
    wget -Oarmbian.img.xz "$armbiandl"
    unxz --decompress armbian.img.xz
fi

#mkdir ark.1.tmpmnt ark.2.tmpmnt armbian.1.tmpmnt armbian.2.tmpmnt ROCKNIX.1.tmpmnt ROCKNIX.2.tmpmnt

lodev=$(losetup -f)
echo ${lodev}

BaseImg=ArkOS_R35S-R36S.img #ROCKNIX-RK3326.aarch64-latest-a.img
NewImg=ArkBianNix.img

echo copy new image
[[ -f "$NewImg" ]] && rm $NewImg
cp $BaseImg $NewImg
BaseImg=$NewImg
sync

BaseImgSzB=$(du -hb $BaseImg|cut -f1)

if [[ "$BaseImgSzB" -lt 30333206528 ]] #32=34359738368
then
    echo resize new image
    needed=$((30333206528-$(du -hb $BaseImg|cut -f1)))
    echo needed $needed 
    # sleep 30
    fallocate -o $(du -hb $BaseImg|cut -f1) -l $needed $BaseImg
    sync
fi
echo size of new image: $(du -hb $BaseImg)
set -e

#add armbian partition and storage
echo setup ${lodev}
sudo losetup -P ${lodev} ${BaseImg}
set +e
echo delete ezroms
printf "d\n3\nw\n" | sudo fdisk ${lodev}
echo move ark down
echo '+1936M' | sudo sfdisk --move-data ${lodev} -N 2
set -e

echo backup boot
mkdir bootresizetmpmnt
sudo mount -o utf8 ${lodev}p1 bootresizetmpmnt
cd bootresizetmpmnt
sudo tar cvf ../bootresizetmp.tar .
cd ..
sudo umount ${lodev}p1

echo resize boot
sudo parted ${lodev} resizepart 1 2064MiB

echo refresh boot
sudo losetup -d ${lodev}
sudo losetup -P ${lodev} ${BaseImg}

echo refill boot
sudo mkfs.vfat -F 32 -n bootnix ${lodev}p1
sudo mount -o utf8 ${lodev}p1 bootresizetmpmnt
cd bootresizetmpmnt
sudo tar xvf ../bootresizetmp.tar 
cd ..
sudo umount ${lodev}p1
sudo rm -rf bootresizetmpmnt
sudo rm bootresizetmp.tar 

echo refresh boot
sudo losetup -d ${lodev}
sudo losetup -P ${lodev} ${BaseImg}
echo resize ark
sudo e2label ${lodev}p2 ark
sudo parted ${lodev} resizepart 2 12GiB
echo refresh ark
sudo losetup -d ${lodev}
sudo losetup -P ${lodev} ${BaseImg}
echo resize ark fs
sudo e2fsck -f /dev/loop0p2
sudo resize2fs ${lodev}p2
echo create armbian partition
sudo parted ${lodev} mkpart primary 12288MiB 28GiB
echo refresh armbian partition
sudo losetup -d ${lodev}
sudo losetup -P ${lodev} ${BaseImg}
echo create ark fs
sudo mkfs.ext4 -L armbian ${lodev}p3
echo create armbian partition
sudo parted ${lodev} mkpart primary 28GiB 100%
echo refresh armbian partition
sudo losetup -d ${lodev}
sudo losetup -P ${lodev} ${BaseImg}
echo create ark fs
sudo mkfs.exfat -c 16K -L EZSTORAGE ${lodev}p4
sudo losetup -d ${lodev}




startdir=$(pwd)
mkdir tmpmnts
cd tmpmnts
mkdir arkbuntnix{1,2,3,4}
mkdir armbian{1,2}
mkdir rocknix{1,2}
for dir in arkbuntnix armbian rocknix
do
    lodev=$(losetup -f)
    umountdevs="$umountdevs $lodev"
    
    [[ "$dir" == "arkbuntnix" ]] && nums="1 2 3" || nums="1 2"
    [[ "$dir" == "arkbuntnix" ]] && imgFile="../arkbuntnix.img" 
    [[ "$dir" == "armbian" ]] && imgFile="../armbian.img" 
    [[ "$dir" == "rocknix" ]] && imgFile="../ROCKNIX-RK3326.aarch64-latest-a.img"

    sudo losetup -P ${lodev} ${imgFile}

    for partnum in ${nums}
    do
        sudo mount ${lodev}p${partnum} ${dir}${partnum}
    done
done
cd "$startdir"

arkbuntnixBoot=$(pwd)/tmpmnts/arkbuntnix1
arkbuntnixArk=$(pwd)/tmpmnts/arkbuntnix2
arkbuntnixArmbian=$(pwd)/tmpmnts/arkbuntnix3

armbianBoot=$(pwd)/tmpmnts/armbian1
armbianRoot=$(pwd)/tmpmnts/armbian2

rocknixBoot=$(pwd)/tmpmnts/rocknix1
rocknixStor=$(pwd)/tmpmnts/rocknix2

sudo rsync -aHAX --no-compress --progress $armbianRoot/ $arkbuntnixArmbian >/dev/null 2>&1

sudo cp $rocknixBoot/KERNEL $arkbuntnixBoot/KERNEL
sudo cp $rocknixBoot/KERNEL.md5 $arkbuntnixBoot/KERNEL.md5
sudo cp $rocknixBoot/SYSTEM $arkbuntnixBoot/SYSTEM
sudo cp $rocknixBoot/SYSTEM.md5 $arkbuntnixBoot/SYSTEM.md5

sudo cp -v --remove-destination boot.ini $arkbuntnixBoot/boot.ini
sudo cp -v --remove-destination boot.ark.ini $arkbuntnixBoot/boot.ark.ini
sudo cp -v --remove-destination boot.armbian.ini $arkbuntnixBoot/boot.armbian.ini
sudo cp -v --remove-destination boot.rocknix.ini $arkbuntnixBoot/boot.rocknix.ini

sudo cp -v --remove-destination ark.fstab $arkbuntnixArk/etc/fstab
sudo cp -v --remove-destination armbian.fstab $arkbuntnixArmbian/etc/fstab
sudo cp -v --remove-destination firstboot.sh $arkbuntnixBoot/firstboot.sh
sudo cp -v --remove-destination arkbuntnix-firstrun.sh $arkbuntnixBoot/arkbuntnix-firstrun.sh

sudo rm -f $arkbuntnixBoot/expandtoexfat.sh

sudo rm -rf "$arkbuntnixBoot/New Screens"
sudo rm -rf "$arkbuntnixBoot/Old Screen"

for i in rg351mp-kernel.dtb rk3326-r35s-linux.dtb rk3326-rg351mp-linux.dtb rk3326-rg351mp-linux.dtb.orig rk3326-rg351mp-linux.dtb.tony
do
    [[ -f "$arkbuntnixBoot/$i" ]] && sudo rm -rf "$arkbuntnixBoot/$i"
done

sudo cp -v --remove-destination -r panels/$panel/* $arkbuntnixBoot

for i in $(mount | grep "$(pwd)" |cut -d' ' -f1)
do
    sudo umount ${i}
done

echo cleanup mntdirs
rm -rf tmpmnts

for i in $(losetup | grep "$(pwd)" |cut -d' ' -f1)
do
    sudo losetup -d ${i}
done

fallocate -d ./$BaseImg

mv $BaseImg "$(echo $BaseImg|sed 's|\.img$||').$(date +%Y-%m-%d-%H%M).img"
#7z a -t7z -m0=lzma2 -mx=9 -md=256m ${BaseImg}.7z $BaseImg

exit 0
