#!/bin/bash

say Installing ${OsName} to ${imgname}

npsz=$(cat sizereq)
sayin new $((npsz/1024))GiB partition
newpart $npsz ext4 $OsName

InstallDev=${ImgLodev}p${partcount}
sayin new dev is ${InstallDev}

sayin setup mounts
ThisBootMnt=${tmpmnts}/boot
mkdir -p "${ThisBootMnt}"

Thislodev=$(losetup -f)
sudo losetup -P ${Thislodev} ${ThisImgName}
sudo mount ${Thislodev}p1 "${ThisBootMnt}"
sudo mkdir -p "${ImgBootMnt}/${OsName}"

sayin copy boot files to ${imgname}

sudo cp -v "boot.${OsName}.ini" "${ImgBootMnt}/boot.${OsName}.ini"

sudo cp -v "${ThisBootMnt}/rk3326-rg351mp-linux.dtb" "${ImgBootMnt}/${OsName}/"
[[ ! -d "${ImgBootMnt}/Screenfiles/" ]] && sudo mkdir "${ImgBootMnt}/Screenfiles/" || echo >/dev/null 2>&1

for i in {0..4}
do
    sudo cp -vf "$StartDir/mipi-panels/Panel $i/mipi-panel.dtbo" "${ImgBootMnt}/Screenfiles/Panel $i/"
done

sayin copy KERNEL and SYSTEM to ${imgname} boot partition
sudo cp -v "${ThisBootMnt}/KERNEL" "${ImgBootMnt}/${OsName}"
sudo cp -v "${ThisBootMnt}/KERNEL.md5" "${ImgBootMnt}/${OsName}"
sudo cp -v "${ThisBootMnt}/SYSTEM" "${ImgBootMnt}/${OsName}"
sudo cp -v "${ThisBootMnt}/SYSTEM.md5" "${ImgBootMnt}/${OsName}"
