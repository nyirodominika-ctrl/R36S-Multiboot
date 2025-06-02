#!/bin/bash
say Post-installing ark to ${imgname}

sayin copy firstrun script
sudo cp "firstboot.sh" "${ImgBootMnt}"
sudo cp "ark-firstrun.sh" "${ImgBootMnt}"

sayin copy fstab
sudo cp --remove-destination "ark.fstab" "${DestMnt}/etc/fstab"
sudo rm -f "${DestMnt}/etc/fstab.ntfs"
sudo cp "setup-ezstorage.service" "${DestMnt}/etc/systemd/system/"



















sayin cleanup mounts and img dev
sync
sudo umount ${arklodev}p1 
sudo umount ${arklodev}p2 
sudo umount ${InstallDev}

sync
sudo losetup -d ${arklodev}

[[ "$BuildImgEnv" == "github" ]] && rm ${arkimgName} || sayin keep ${arkimgName}