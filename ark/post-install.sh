#!/bin/bash
say Post-installing ark to ${imgname}

sayin copy firstrun script
sudo cp "firstboot.sh" "${ImgBootMnt}/ark"
sudo sed -i 's|ExecStart=/boot/firstboot.sh|ExecStart=/boot/ark/firstboot.sh|' "${DestMnt}/etc/systemd/system/firstboot.service"
sudo cp "ark-firstrun.sh" "${ImgBootMnt}/ark"

sayin copy fstab
sudo cp --remove-destination "ark.fstab" "${DestMnt}/etc/fstab"
sudo rm -f "${DestMnt}/etc/fstab.ntfs"
sudo cp "setup-ezstorage.service" "${DestMnt}/etc/systemd/system/"



















sayin cleanup mounts and img dev
sync
sleep 5
sudo umount ${arklodev}p1
sudo umount ${arklodev}p2
sudo umount ${InstallDev}

sync
sudo losetup -d ${arklodev}

[[ "$BuildImgEnv" == "github" ]] && rm ${ThisImgName} || sayin keep ${ThisImgName}