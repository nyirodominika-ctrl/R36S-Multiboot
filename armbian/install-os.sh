#!/bin/bash
say Installing armbian to ${imgname}
function sayin {
    echo ► $@
}

sayin new 16GiB partition
newpart 16384 ext4 armbian
InstallDev=${ImgLodev}p${partcount}
sayin new dev is ${InstallDev} 

sayin setup mounts
armbianRootMnt=${tmpmnts}/root
mkdir -p "${armbianRootMnt}" 
armbianlodev=$(losetup -f)
sudo losetup -P ${armbianlodev} ${ThisimgName}
sudo mount ${armbianlodev}p2 "${armbianRootMnt}"

sync

sayin mount ${InstallDev} "${DestMnt}"
DestMnt=${tmpmnts}/${imgname}-armbian
mkdir -p "${DestMnt}"
sudo mount ${InstallDev} "${DestMnt}"

sayin copy boot files to ${imgname}
[[ ! -d "${ImgBootMnt}/rg351mp-kernel.dtb" ]] && sudo cp -R "panels/4-60hz/rg351mp-kernel.dtb" "${ImgBootMnt}/" || echo >/dev/null 2>&1
[[ ! -d "${ImgBootMnt}/rk3326-r35s-linux.dtb" ]] && sudo cp -R "panels/4-60hz/rk3326-r35s-linux.dtb" "${ImgBootMnt}/" || echo >/dev/null 2>&1
[[ ! -d "${ImgBootMnt}/rk3326-r35s-linux.dtb" ]] && sudo cp "rk3326-gameconsole-r36s.dtb" "${ImgBootMnt}/" || echo >/dev/null 2>&1
[[ ! -d "${ImgBootMnt}/panels" ]] && sudo cp -R "panels" "${ImgBootMnt}/" || echo >/dev/null 2>&1
sudo cp "boot.armbian.ini" "${ImgBootMnt}/"
sudo mkdir -p "${ImgBootMnt}/armbian"
sudo cp "kernel/Image" "${ImgBootMnt}/armbian/"
sudo cp "kernel/uInitrd" "${ImgBootMnt}/armbian/"

sayin copy root to ${imgname}
sudo rsync -aHAX --no-compress ${armbianRootMnt}/ ${DestMnt} >/dev/null 2>&1

sudo sed -i 's|UUID=.* / ext4|LABEL=armbian / ext4|' "${DestMnt}/etc/fstab"
sudo sed -i 's|UUID=.* /boot/efi vfat|#LABEL=boot /boot/efi vfat|' "${DestMnt}/etc/fstab"
