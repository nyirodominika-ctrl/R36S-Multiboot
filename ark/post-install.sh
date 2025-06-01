#!/bin/bash
say Post-installing ark to ${imgname}

sayin copy firstrun script
sudo cp "firstboot.sh" "${ImgBootMnt}"
sudo cp "ark-firstrun.sh" "${ImgBootMnt}"

sayin copy fstab
sudo rm "${arkRootMnt}/etc/fstab"
sudo cp "ark.fstab" "${arkRootMnt}/etc/fstab"
cat "${arkRootMnt}/etc/fstab" |grep 'LABEL=ark' || exit 1
sudo cp "setup-ezstorage.service" "${arkRootMnt}/etc/systemd/system/"



















sayin cleanup mounts and img dev
sync
sudo umount ${arklodev}p1 
sudo umount ${arklodev}p2 
sudo umount ${InstallDev}

sync
sudo losetup -d ${arklodev}

[[ "$BuildImgEnv" == "github" ]] && rm ${arkimgName}