#!/bin/bash

say Installing ${OsName} to ${imgname}

npsz=$(cat bootsizereq)
sayin new $((npsz/1024))GiB partition
OsBootLabel=$(echo $OsName |sed 's|nix||'|sed 's|elec||')
OsBootLabel=${OsBootLabel}boot
newpart $npsz fat $OsBootLabel
ThisBootPartNum=${partcount}
ThisBootDev=${ImgLodev}p${ThisBootPartNum}
sayin new boot is ${ThisBootDev}

npsz=$(cat sizereq)
sayin new $((npsz/1024))GiB partition
newpart $npsz ext4 $OsName
ThisRootPartNum=${partcount}
ThisRootDev=${ImgLodev}p${ThisRootPartNum}
sayin new root is ${ThisRootDev}

sayin setup mounts
# os boot part has all we need
OSBootMnt=${tmpmnts}/os-${OsName}-boot
mkdir -p "${OSBootMnt}"
Thislodev=$(losetup -f)
sudo losetup -P ${Thislodev} ${ThisImgName}
sudo mount ${Thislodev}p1 "${OSBootMnt}"
#sudo mkdir -p "${ImgBootMnt}/${OsName}"

sayin copy boot files to ${imgname}
sudo cp -v "boot.${OsName}.ini" "${ImgBootMnt}/boot.${OsName}.ini"
ThisBootPartNumHex=$(printf '%x\n' ${ThisBootPartNum})
sudo sed -i "s|###bootPartNum###|${ThisBootPartNumHex}|g" "${ImgBootMnt}/boot.${OsName}.ini"

# mount boot partition
DestBootMnt=${tmpmnts}/boot-${OsName}
mkdir -p "${DestBootMnt}"

sudo mount ${ThisBootDev} "${DestBootMnt}"

if [[ -d "ScreenFiles" ]]
then
    sayin copy ScreenFiles to ${imgname} boot partition
    sudo cp -R "ScreenFiles" "${DestBootMnt}/"
else
    dtbname=$(cat dtbname)
    sudo cp -v "${OSBootMnt}/${dtbname}" "${DestBootMnt}"
    # [[ ! -d "${ImgBootMnt}/ScreenFiles/" ]] && sudo mkdir "${ImgBootMnt}/ScreenFiles/" || echo >/dev/null 2>&1
    for i in {0..4}
    do
        [[ ! -d "${ImgBootMnt}/ScreenFiles/Panel $i/" ]] && sudo mkdir "${ImgBootMnt}/ScreenFiles/Panel $i/"
        [[ ! -f "${ImgBootMnt}/ScreenFiles/Panel $i/mipi-panel.dtbo" ]] && sudo cp -vf "$StartDir/mipi-panels/Panel $i/mipi-panel.dtbo" "${ImgBootMnt}/ScreenFiles/Panel $i/"
    done
fi

sayin copy KERNEL and SYSTEM to ${imgname} boot partition
sudo cp -v "${OSBootMnt}/KERNEL" "${DestBootMnt}"
sudo cp -v "${OSBootMnt}/KERNEL.md5" "${DestBootMnt}"
sudo cp -v "${OSBootMnt}/SYSTEM" "${DestBootMnt}"
sudo cp -v "${OSBootMnt}/SYSTEM.md5" "${DestBootMnt}"
