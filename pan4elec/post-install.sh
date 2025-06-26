#!/bin/bash
say Post-installing ${OsName} to ${imgname}



sayin mount ${InstallDev} "${DestMnt}"
DestMnt=${tmpmnts}/${imgname}-${OsName}
mkdir -p "${DestMnt}"
sudo mount ${InstallDev} "${DestMnt}"


# sudo mkdir -p "${DestMnt}/.config/autostart"

# sudo cp 00-mount-EZSTORAGE.sh "${DestMnt}/.config/autostart/00-mount-EZSTORAGE.sh"
# sudo chmod a+x "${DestMnt}/.config/autostart/00-mount-EZSTORAGE.sh"

# sudo cp 01-expand-EZSTORAGE.sh "${DestMnt}/.config/autostart/01-expand-EZSTORAGE.sh"
# sudo chmod a+x "${DestMnt}/.config/autostart/01-expand-EZSTORAGE.sh"

# sudo cp 02-setup-EZSTORAGE.sh "${DestMnt}/.config/autostart/02-setup-EZSTORAGE.sh"
# sudo chmod a+x "${DestMnt}/.config/autostart/02-setup-EZSTORAGE.sh"














sayin cleanup mounts and img dev
sync
sudo umount ${Thislodev}p1 
sudo umount ${InstallDev}

sync
sudo losetup -d ${Thislodev}
[[ "$BuildImgEnv" == "github" ]] && rm ${ThisImgName} || sayin keep ${ThisImgName}