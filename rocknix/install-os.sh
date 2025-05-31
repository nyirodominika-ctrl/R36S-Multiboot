#!/bin/bash

say Installing rocknix to ${imgname}
function sayin {
    echo ► $@
}


sayin new 384MiB partition

newpart 384 ext4 rocknix

InstallDev=${ImgLodev}p${partcount}
sayin new dev is ${InstallDev} 

sayin setup mounts
rocknixBootMnt=${tmpmnts}/boot
mkdir -p "${rocknixBootMnt}" 

rocknixlodev=$(losetup -f)
sudo losetup -P ${rocknixlodev} ${ThisimgName}
sudo mount ${rocknixlodev}p1 "${rocknixBootMnt}"

# sayin mount ${InstallDev} "${DestMnt}"
# DestMnt=${tmpmnts}/${imgname}-rocknix
# mkdir -p "${DestMnt}"
# sudo mount ${InstallDev} "${DestMnt}"

sayin copy boot files to ${imgname}
sudo cp "${rocknixBootMnt}/rk3326-gameconsole-r36s.dtb" "${ImgBootMnt}/"
sudo cp -R "panels/4-60hz/overlays" "${ImgBootMnt}/"
sudo cp -R "panels" "${ImgBootMnt}/"
sudo cp  "boot.rocknix.ini" "${ImgBootMnt}/"


sayin copy KERNEL and SYSTEM to ${imgname} boot partition
sudo cp "${rocknixBootMnt}/KERNEL" "${ImgBootMnt}"
sudo cp "${rocknixBootMnt}/KERNEL.md5" "${ImgBootMnt}"
sudo cp "${rocknixBootMnt}/SYSTEM" "${ImgBootMnt}"
sudo cp "${rocknixBootMnt}/SYSTEM.md5" "${ImgBootMnt}"
