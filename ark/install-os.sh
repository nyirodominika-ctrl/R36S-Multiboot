#!/bin/bash
set -e
say Installing ark to ${imgname}
function sayin {
    echo ► $@
}

sayin new 10GiB partition
newpart 10240 ext4 ark
InstallDev=${ImgLodev}p${partcount}
sayin new dev is ${InstallDev} 

sayin setup mounts
arkBootMnt=${tmpmnts}/boot
arkRootMnt=${tmpmnts}/root
[[ ! -d "${arkBootMnt}" ]] && mkdir -p "${arkBootMnt}"
[[ ! -d "${arkRootMnt}" ]] && mkdir -p "${arkRootMnt}"

arklodev=$(losetup -f)
sudo losetup -P ${arklodev} ${arkimgName}

sudo mount ${arklodev}p1 "${arkBootMnt}" || exit 1
sudo mount ${arklodev}p2 "${arkRootMnt}" || exit 1
sync

sayin copy boot files to ${ImgBootMnt}

sudo cp "${arkBootMnt}/Image" "${ImgBootMnt}/"
sudo cp "${arkBootMnt}/uInitrd" "${ImgBootMnt}/"

mkdir -p "${ImgBootMnt}/panels/4-60hz"
sudo cp "${arkBootMnt}/New Screens/Panel 4 - 60hz/rg351mp-kernel.dtb" "${ImgBootMnt}/panels/4-60hz"
sudo cp "${arkBootMnt}/New Screens/Panel 4 - 60hz/rk3326-r35s-linux.dtb" "${ImgBootMnt}/panels/4-60hz"

sudo cp "${arkBootMnt}/New Screens/Panel 4 - 60hz/rg351mp-kernel.dtb" "${ImgBootMnt}"
sudo cp "${arkBootMnt}/New Screens/Panel 4 - 60hz/rk3326-r35s-linux.dtb" "${ImgBootMnt}"
sudo cp -R "boot.ark.ini" "${ImgBootMnt}/"

for i in 1 2 3 4
do
    sudo cp "${arkBootMnt}/New Screens/Panel $i/rg351mp-kernel.dtb" "${ImgBootMnt}/panels/$i"
    sudo cp "${arkBootMnt}/New Screens/Panel $i/rk3326-r35s-linux.dtb" "${ImgBootMnt}/panels/$i"
done

DestMnt=${tmpmnts}/${imgname}-ark
sayin mount ${InstallDev} "${DestMnt}"
mkdir -p "${DestMnt}" || exit 1
sudo mount ${InstallDev} "${DestMnt}" || exit 1
sayin copy root to ${imgname}
sudo rsync -aHAX --no-compress ${arkRootMnt}/ ${DestMnt} >/dev/null 2>&1
