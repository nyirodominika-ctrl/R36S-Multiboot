#!/bin/bash
say Post-installing ${OsName} to ${imgname}



sayin mount ${ThisRootDev} "${DestMnt}"
DestMnt=${tmpmnts}/${imgname}-${OsName}
mkdir -p "${DestMnt}"
sudo mount ${ThisRootDev} "${DestMnt}"

sudo mkdir -p "${DestMnt}/.config/autostart"

[[ -f custom_start.sh ]] && sudo cp -vL custom_start.sh "${DestMnt}/.config/custom_start.sh"
[[ -f custom_start.sh ]] && sudo chmod a+x "${DestMnt}/.config/custom_start.sh"

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