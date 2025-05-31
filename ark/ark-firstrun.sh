#!/bin/bash

[[ -f /EZSTORAGE/.uglystuff/storagewasexpanded ]] && notExpanded=0 || notExpanded=1
  
  sudo chmod 666 /dev/tty1
  export TERM=linux
  height="15"
  width="55"
  sudo setfont /usr/share/consolefonts/Lat7-Terminus20x10.psf.gz
  height="20"
  width="60"

# [ $notExpanded -eq 1 ] && \
#   dialog --infobox "debug expand file found" $height $width 2>&1 > /dev/tty1 || \
#   dialog --infobox "debug expand file not found" $height $width 2>&1 > /dev/tty1
# sleep 15

if [ $notExpanded -eq 1 ]
then
  sudo umount /EZSTORAGE
export EZSDevPart=$(sudo blkid |grep EZSTORAGE |cut -d: -f1)
export EZSPartNum=$(echo ${EZSDevPart} | cut -dp -f2)
export EZSDev=$(echo ${EZSDevPart} | cut -dp -f1)
echo EZSTORAGE partition device is ${EZSDevPart};echo EZSTORAGE device is ${EZSDev} ;echo EZSTORAGE partition number is ${EZSPartNum} 
 

  # sudo chmod 666 /dev/tty1
  # export TERM=linux
  # height="15"
  # width="55"
  # sudo setfont /usr/share/consolefonts/Lat7-Terminus20x10.psf.gz
  # height="20"
  # width="60"

  if [ ! -f /boot/doneit ]; then
    sudo echo ", +" | sudo sfdisk -N ${EZSPartNum} --force ${EZSDev} 
    sudo touch "/boot/doneit"
    dialog --infobox "EASYROMS partition expansion and conversion to exfat in process.  The device will now reboot to continue the process..." $height $width 2>&1 > /dev/tty1
    sleep 5
    sudo reboot
  fi

  mkfs.fat -F32 -v -I -n EZSTORAGE ${EZSDevPart} || sleep 30
  sync
  sleep 2
  sudo fsck.fat -a ${EZSDevPart}
  sync

  sudo mount -w ${EZSDevPart} /EZSTORAGE
  exitcode=$?

  mkdir /EZSTORAGE/.uglystuff
  sudo touch "/EZSTORAGE/.uglystuff/storagewasexpanded"

fi

[[ -z "$exitcode" ]] && exitcode=0

#mkdir -p /EZSTORAGE/.uglystuff/ark/roms
sudo sed -i 's|##pre-firstrun##||' /etc/fstab 
sudo mount -a 
sleep 2
sudo /bin/bash /boot/setup-ezstorage.sh ark || sleep 30
sleep 5
sudo tar -xvf /roms.tar -C /
sync

sudo rm -rf -v /roms/themes/es-theme-nes-box/
sudo mv -f -v /tempthemes/* /roms/themes
sync
sleep 1
sudo rm -rf -v /tempthemes

sudo rm -f /boot/doneit*
if [ ! -f "/boot/rk3326-rg351v-linux.dtb" ] && [ ! -f "/boot/rk3326-rg351mp-linux.dtb" ]; then
  sudo rm -f /roms.tar
fi
sudo rm -f /boot/fstab.*

sudo systemctl enable ssh
if [ $exitcode -eq 0 ]; then
  dialog --infobox "Completed expansion of EZSTORAGE. The system will now reboot and load ArkOS." $height $width 2>&1 > /dev/tty1 | sleep 10
  systemctl disable firstboot.service
  sudo systemctl disable firstboot.service
  sudo systemctl enable setup-ezstorage.service
  #sudo rm -v /boot/firstboot.sh
  #sudo rm -v /boot/ark-firstrun.sh
  sudo mv /boot/firstboot.sh{,.ran}
  #sudo rm -v -- "$0"
  reboot
else
  dialog --infobox "EZSTORAGE partition expansion failed for an unknown reason.  Please expand the partition using an alternative tool such as Minitool Partition Wizard.  System will reboot and load ArkOS now." $height $width 2>&1 > /dev/tty1 | sleep 10
  systemctl disable firstboot.service
  sudo systemctl disable firstboot.service
  #sudo rm -v /boot/firstboot.sh
  sudo mv /boot/firstboot.sh{,.failed}
  #sudo rm -v -- "$0"
  reboot
fi
