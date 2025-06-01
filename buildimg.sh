#!/bin/bash

function say {
    echo
    echo $@
}
u=$(id -u)
g=$(id -g)
imgname=R36S-Multiboot

ImgDir=$(pwd)
BuildingImgFullPath=${ImgDir}/building.img
[[ -f "$BuildingImgFullPath" ]] && rm "$BuildingImgFullPath" 

for mp in $(mount | grep "$(pwd)" |cut -d' ' -f1)
do
    sudo umount "${mp}" && echo ${mp} was stll mounted || exit 1

done

[[ -d tmp ]] && rm -rf tmp || echo >/dev/null 2>&1
[[ -d tmp ]] && exit 1

for ld in $(losetup | grep "$(pwd)" |cut -d' ' -f1)
do
    echo
    sudo losetup -d ${ld} && echo ${ld} was stll attached to an image || exit 1
done

mkdir tmp

partcount=0
nextpartstart=16
bootsize=112
imgsizereq=32
storagesize=256

for arg in "$@"; do
    thissizereq=0
    [[ "$arg" = "rocknix" ]] && bootsize=$((bootsize + 2032)) || bootsize=$((bootsize + 128))
    if [[ -f "$arg/sizereq" ]] 
    then
        thissizereq=$(cat "$arg/sizereq")
        imgsizereq=$((imgsizereq + thissizereq))
    fi
done

imgsizereq=$((storagesize + imgsizereq))

imgsize=$((bootsize + imgsizereq + 16))

echo imgsize is $imgsize
echo bootsize is $bootsize

set -e

say make base image ${imgsize}MiB
ImgLodev=$(losetup -f)

fallocate -l ${imgsize}MiB ${BuildingImgFullPath}

sudo losetup -P ${ImgLodev} ${BuildingImgFullPath}

function refreshBuildimg {
    sync
    echo ► refresh ${ImgLodev}
    [[ ! -z "${ImgBootMnt}" ]] && echo ►► umount "${ImgBootMnt}" || echo >/dev/null 2>&1
    [[ ! -z "${ImgBootMnt}" ]] && sudo umount "${ImgBootMnt}" || echo >/dev/null 2>&1
    sudo losetup -d ${ImgLodev}
    sleep 3
    sync
    sudo losetup -P ${ImgLodev} ${BuildingImgFullPath}
    sleep 3
    [[ ! -z "${ImgBootMnt}" ]] && echo ►► mount ${ImgLodev}p1 "${ImgBootMnt}" || echo >/dev/null 2>&1
    [[ ! -z "${ImgBootMnt}" ]] && sudo mount ${ImgLodev}p1 "${ImgBootMnt}" || echo >/dev/null 2>&1
}

if [[ ! -d u-boot ]]
then
    say get u-boot
    [[ -z "${UBootBuilderRepo}" ]] && UBootBuilderRepo=EatPrilosec || say UBootBuilderRepo=${UBootBuilderRepo}
    git clone https://github.com/${UBootBuilderRepo}/R36S-u-boot-builder.git u-boot >/dev/null 2>&1
    cd u-boot
    chmod a+x build-uboot.sh

    say build u-boot
    ./build-uboot.sh >/dev/null 2>&1 || exit 1
    cd ..
fi
cd u-boot
if [[ ! -f u-boot-r36s.tar ]]
then
    chmod a+x build-uboot.sh
    say build u-boot
    ./build-uboot.sh >/dev/null 2>&1 || exit 1
fi
say add uboot
if [[ ! -d "sd_fuse" ]] 
then
    mkdir sd_fuse
    tar xf u-boot-r36s.tar -C sd_fuse
fi
cd sd_fuse
chmod a+x ./sd_fusing.sh 
./sd_fusing.sh ${ImgLodev} >/dev/null 2>&1
cd "${ImgDir}"

say create partition table
sudo parted -s ${ImgLodev} mklabel gpt || echo

function newpart {
    local start=$nextpartstart
    local partsize=$1
    local end=$((start + partsize))
    echo ► create from ${start}MiB to ${end}MiB
    [[ "$2" == "fat" ]] && local type=fat32 || echo >/dev/null 2>&1
    [[ "$2" == "ext4" ]] && local type=ext4 || echo >/dev/null 2>&1

    sudo parted -s ${ImgLodev} mkpart primary $type ${start}MiB ${end}MiB || echo >/dev/null 2>&1
    refreshBuildimg
    ls ${ImgLodev}p$((partcount + 1)) >/dev/null 2>&1 && partcount=$((partcount + 1)) || exit 1
    nextpartstart=${end}

    if [[ "$2" == "fat" ]]
    then
        if [[ -z "$3" ]]
        then
            #echo
            echo ► format as fat
            sudo mkfs.vfat -F 32 ${ImgLodev}p${partcount} >/dev/null 2>&1
        else 
            #echo
            echo ► format as fat with label $3
            sudo mkfs.vfat -F 32 -n $3 ${ImgLodev}p${partcount} >/dev/null 2>&1
        fi
    fi

    if [[ "$2" == "ext4" ]]
    then
        if [[ -z "$3" ]]
        then
            #echo
            echo ► format as ext4
            sudo mkfs.ext4 ${ImgLodev}p${partcount} >/dev/null 2>&1
        else 
            #echo
            echo ► format as ext4 with label $3
            sudo mkfs.ext4 -L $3 ${ImgLodev}p${partcount} >/dev/null 2>&1
        fi
    fi
    sync
    [[ "$3" == "returndev" ]] && return "${ImgLodev}p${partcount}" || echo >/dev/null 2>&1
}

say create boot partition 
newpart ${bootsize} fat boot
ImgBootMnt="${ImgDir}/tmp/boot.tmpmnt"
mkdir -p "${ImgBootMnt}"
sudo mount ${ImgLodev}p${partcount} "${ImgBootMnt}"
sleep 3

say fill boot partition 
sudo cp -R commonbootfiles/* "${ImgBootMnt}"

function bootiniadd {
    echo "$@" | sudo tee --append "${ImgBootMnt}/boot.ini"
}

bootiniadd odroidgoa-uboot-config
bootiniadd ""
bootiniadd setenv boot2 $1
bootiniadd ""

for arg in "$@"; do
    thisbtn=$(cat $arg/bootbutton)
    bootiniadd if gpio input $thisbtn
    bootiniadd then
    bootiniadd "    setenv boot2 $arg"
    bootiniadd fi
    bootiniadd ""
done

bootiniadd 'echo booting ${boot2}'
bootiniadd 'load mmc 1:1 0x00800800 boot.${boot2}.ini'
bootiniadd source 0x00800800

echo
cat "${ImgBootMnt}/boot.ini"

sleep 20
for arg in "$@"; do
    tmpmnts="${ImgDir}/tmp/${arg}.tmpmnts"
    mkdir -p "$tmpmnts" 
    cd "${ImgDir}/${arg}"
    chmod a+x ./*.sh

    for step in get-image install-os post-install
    do
        echo
        [[ -f "./${step}.sh" ]] && echo Start: ${arg}: ${step} || echo skipping ${step}...
        echo
        [[ -f "./${step}.sh" ]] && echo source ./${step}.sh  || continue
        echo
        source ./${step}.sh 
        echo End: ${step}
        echo
    done
    sync 
done
cd "${ImgDir}"

say create storage partition 
newpart ${storagesize} fat EZSTORAGE
Storagemount="${ImgDir}/tmp/storage.tmpmnt"

[[ -d commonStoragefiles ]] && say fill storage partition 
[[ -d commonStoragefiles ]] && mkdir -p "${Storagemount}"
[[ -d commonStoragefiles ]] && sudo mount ${ImgLodev}p${partcount} "${Storagemount}"
[[ -d commonStoragefiles ]] && sudo cp -R commonStoragefiles/* "${Storagemount}" || echo >/dev/null 2>&1


say finalize image
sync
sudo umount "${ImgBootMnt}"
[[ -d commonStoragefiles ]] && sudo umount "${Storagemount}" || echo >/dev/null 2>&1
sudo losetup -d ${ImgLodev}
sync


OutImgNameNoExt=${imgname}-$(echo "$@" |sed 's| |-|g')-$(TZ=America/New_York date +%Y-%m-%d-%H%M)

OutImg=${ImgDir}/${OutImgNameNoExt}.img
OutImgXZ=${ImgDir}/${OutImgNameNoExt}.img.xz
OutImg7z=${ImgDir}/${OutImgNameNoExt}.img.xz.7z


echo ${OutImg}

mv ${BuildingImgFullPath} ${OutImg}
sync

if [[ "$BuildImgEnv" == "github" ]]
then
    fallocate --dig-holes ${OutImg}

    xz -z -7 -T0 ${OutImg}

    7z a -mx9 -md512m -mfb273 -mmt2 -v2000m ${OutImg7z} ${OutImgXZ}
    ls ${ImgDir}/${imgname}-*
fi

sync
