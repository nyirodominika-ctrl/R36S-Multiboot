#!/bin/bash

say Post-installing armbian to ${imgname}
# usr/lib/armbian/armbian-resize-filesystem
cat << EOF | sudo tee ${DestMnt}/usr/lib/armbian/armbian-resize-filesystem
#!/bin/bash
systemctl disable armbian-resize-filesystem
exit 0
EOF




sayin cleanup mounts and img dev
sync
#sudo umount ${armbianlodev}p1
sudo umount ${armbianlodev}p2
sudo umount ${InstallDev}

sync
sudo losetup -d ${armbianlodev}

[[ "$BuildImgEnv" == "github" ]] && rm ${ThisImgName} || sayin keep ${ThisImgName}

