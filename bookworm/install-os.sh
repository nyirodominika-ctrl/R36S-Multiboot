#!/bin/bash
say Installing $OsName to ${imgname}

npsz=$(cat sizereq)
sayin new $((npsz/1024))GiB partition
newpart $npsz ext4 $OsName
InstallDev=${ImgLodev}p${partcount}
sayin new root part is ${InstallDev} 

sayin setup mounts
armbianRootMnt=${tmpmnts}/root
mkdir -p "${armbianRootMnt}" 
armbianlodev=$(losetup -f)
sudo losetup -P ${armbianlodev} ${ThisImgName}
sudo mount ${armbianlodev}p2 "${armbianRootMnt}"

sync

DestMnt=${tmpmnts}/${imgname}-$ThisImgName
sayin mount ${InstallDev} "${DestMnt}"
mkdir -p "${DestMnt}"
sudo mount ${InstallDev} "${DestMnt}"

sayin copy boot files to ${imgname}

sudo cp "boot.armbian.ini" "${ImgBootMnt}/boot.${OsName}.ini"
ThisRootPartNumHex=$(printf '%x\n' ${partcount})
sudo sed -i "s|###rootPartNum###|${ThisRootPartNumHex}|g" "${ImgBootMnt}/boot.${OsName}.ini"
sudo sed -i "s|root=LABEL=armbian|root=LABEL=${OsName}|g" "${ImgBootMnt}/boot.${OsName}.ini"
root=LABEL=armbian

for i in {0..4}
do
    [[ ! -d "${ImgBootMnt}/ScreenFiles/Panel $i/" ]] && sudo mkdir "${ImgBootMnt}/ScreenFiles/Panel $i/"
    [[ ! -f "${ImgBootMnt}/ScreenFiles/Panel $i/mipi-panel.dtbo" ]] && sudo cp -vf "$StartDir/mipi-panels/Panel $i/mipi-panel.dtbo" "${ImgBootMnt}/ScreenFiles/Panel $i/"
done

sayin copy root to ${imgname}
sudo rsync -aHAX --no-compress ${armbianRootMnt}/ ${DestMnt} >/dev/null 2>&1

sudo sed -i 's|UUID=.* / ext4|LABEL=armbian / ext4|' "${DestMnt}/etc/fstab"
sudo sed -i 's|UUID=.* /boot/u-boot vfat|LABEL=boot /boot/u-boot vfat|' "${DestMnt}/etc/fstab"
