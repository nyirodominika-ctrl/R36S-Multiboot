#!/bin/bash

say Post-installing armbian to ${imgname}









sayin cleanup mounts and img dev
sync
#sudo umount ${armbianlodev}p1 
sudo umount ${armbianlodev}p2
sudo umount ${InstallDev}

sync
sudo losetup -d ${armbianlodev}

[[ "$BuildImgEnv" == "github" ]] && rm ${ThisimgName} || sayin keep ${ThisimgName}

