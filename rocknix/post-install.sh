#!/bin/bash
say Post-installing ${OsName} to ${imgname}

sayin mount ${ThisRootDev} "${DestMnt}"
DestMnt=${tmpmnts}/${imgname}-${OsName}
mkdir -p "${DestMnt}"
sudo mount ${ThisRootDev} "${DestMnt}"

if [[ -f ez.service ]]
then
    sudo mkdir -p "${DestMnt}/.config/system.d/amberelec.target.wants/"
    sudo cp -vL ez.service "${DestMnt}/.config/system.d/ez.service"
    sudo ln -sr "${DestMnt}/.config/system.d/ez.service" "${DestMnt}/.config/system.d/amberelec.target.wants/ez.service"
    sudo chmod a+x "${DestMnt}/.config/system.d/ez.service"
fi

sudo mkdir -p "${DestMnt}/.config/autostart"
sudo cp -vL 00-mount-EZSTORAGE.sh "${DestMnt}/.config/autostart/00-mount-EZSTORAGE.sh"
sudo chmod a+x "${DestMnt}/.config/autostart/00-mount-EZSTORAGE.sh"

sudo cp -vL 01-expand-EZSTORAGE.sh "${DestMnt}/.config/autostart/01-expand-EZSTORAGE.sh"
sudo chmod a+x "${DestMnt}/.config/autostart/01-expand-EZSTORAGE.sh"

sudo cp -vL 02-setup-EZSTORAGE.sh "${DestMnt}/.config/autostart/02-setup-EZSTORAGE.sh"
sudo chmod a+x "${DestMnt}/.config/autostart/02-setup-EZSTORAGE.sh"














sayin cleanup mounts and img dev
sync
sudo umount ${Thislodev}p1
sudo umount ${ThisBootDev}
sudo umount ${ThisRootDev}

sync
sudo losetup -d ${Thislodev}
[[ "$BuildImgEnv" == "github" ]] && rm ${ThisImgName} || sayin keep ${ThisImgName}