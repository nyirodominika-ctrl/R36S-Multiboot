#!/bin/bash
set -e
say Installing ark to ${imgname}

npsz=$(cat sizereq)
sayin new $((npsz/1024))GiB partition
newpart $npsz ext4 $OsName
InstallDev=${ImgLodev}p${partcount}
sayin new dev is ${InstallDev} 

sayin setup mounts
arkBootMnt=${tmpmnts}/boot
arkRootMnt=${tmpmnts}/root
[[ ! -d "${arkBootMnt}" ]] && mkdir -p "${arkBootMnt}"
[[ ! -d "${arkRootMnt}" ]] && mkdir -p "${arkRootMnt}"

arklodev=$(losetup -f)
sudo losetup -P ${arklodev} ${ThisImgName}

sudo mount ${arklodev}p1 "${arkBootMnt}" || exit 1
sudo mount ${arklodev}p2 "${arkRootMnt}" || exit 1
sync

sayin copy boot files to ${ImgBootMnt}

sudo cp "${arkBootMnt}/Image" "${ImgBootMnt}/"
sudo cp "${arkBootMnt}/uInitrd" "${ImgBootMnt}/"

sudo cp -R "boot.ark.ini" "${ImgBootMnt}/"

sudo mkdir -p "${ImgBootMnt}/ark"
for i in 0 1 2 3 4
do
    sudo mkdir -p "${ImgBootMnt}/ark/ScreenFiles/Panel $i"
    sudo cp "${arkBootMnt}/ScreenFiles/Panel $i/rk3326-r35s-linux.dtb" "${ImgBootMnt}/ark/ScreenFiles/Panel $i"
done

DestMnt=${tmpmnts}/${imgname}-ark
sayin mount ${InstallDev} "${DestMnt}"
mkdir -p "${DestMnt}" || exit 1
sudo mount ${InstallDev} "${DestMnt}" || exit 1
sayin copy root to ${imgname}
sudo rsync -aHAX --no-compress ${arkRootMnt}/ ${DestMnt} >/dev/null 2>&1
sync

