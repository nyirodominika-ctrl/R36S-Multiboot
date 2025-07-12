#!/bin/bash
say Post-installing ${OsName} to ${imgname}

DestMnt=${tmpmnts}/${imgname}-${OsName}
sayin mount ${ThisRootDev} "${DestMnt}"
mkdir -p "${DestMnt}"
sudo mount ${ThisRootDev} "${DestMnt}"

sudo mkdir -p "${DestMnt}/.config/system.d/"
sudo cp -vL ez.service "${DestMnt}/.config/system.d/ez.service"
sudo chmod a+x "${DestMnt}/.config/system.d/ez.service"


# if [[ "${OsName}" == amberelec ]] || [[ "${OsName}" == pan4elec ]]
# then
# cat << EOF | sudo tee "${DestMnt}/.config/custom_start.sh"
# #!/bin/sh

# case "${1}" in
# "before")
#     systemctl start ez
#     exit 0
#     ;;
# *)
#     exit 0
#         ;;
# esac

# exit 0
# EOF
# sudo chmod a+x "${DestMnt}/.config/custom_start.sh"
# fi


if [[ "${OsName}" == amberelec ]] || [[ "${OsName}" == pan4elec ]]
then
    sudo mkdir -p "${DestMnt}/.config/system.d/amberelec-autostart.service.wants"
    sudo ln -s "/storage/.config/system.d/ez.service" "${DestMnt}/.config/system.d/amberelec-autostart.service.wants/ez.service"
fi

if [[ "${OsName}" == rocknix ]]
then
    sudo mkdir -p "${DestMnt}/.config/system.d/rocknix-autostart.service.wants"
    sudo ln -s "/storage/.config/system.d/ez.service" "${DestMnt}/.config/system.d/rocknix-autostart.service.wants/ez.service"
    sudo ln -s /dev/null "${DestMnt}/.config/system.d/rocknix-automount.service"
fi

if [[ "${OsName}" == uos ]]
then
    sudo mkdir -p "${DestMnt}/.config/system.d/unofficialos-autostart.service.wants"
    sudo ln -s "/storage/.config/system.d/ez.service" "${DestMnt}/.config/system.d/unofficialos-autostart.service.wants/ez.service"
    sudo ln -s /dev/null "${DestMnt}/.config/system.d/unofficialos-automount.service"
fi




sudo mkdir -p "${DestMnt}/.config/udev.rules.d/"
cat << EOF | sudo tee "${DestMnt}/.config/udev.rules.d/95-udevil-mount.rules" >/dev/null 2>&1
# dont run in "installer" mode
IMPORT{cmdline}="installer"
ENV{installer}=="1", GOTO="exit"

# check for blockdevices, /dev/sd*, /dev/sr* and /dev/mmc*
SUBSYSTEM!="block", KERNEL!="sd*|sr*|mmc*", GOTO="exit"

# check for ez2
IMPORT{builtin}="blkid"
ENV{ID_FS_LABEL}=="EZSTORAGE2", GOTO="eztwo"
GOTO="exit"

# mount EZStorage2
LABEL="eztwo"
ACTION=="add", PROGRAM="/usr/bin/sh -c '/usr/bin/grep -E ^/dev/%k\  /proc/mounts || true'", RESULT=="", RUN+="/usr/bin/bash /storage/.config/ez/ez2.sh add"
ACTION=="remove", RUN+="/usr/bin/bash /storage/.config/ez/ez2.sh rm"
GOTO="exit"

# Exit
LABEL="exit"
EOF

sudo mkdir -p "${DestMnt}/.config/ez"
sudo cp -vL 00-mount-EZSTORAGE.sh "${DestMnt}/.config/ez/00-mount-EZSTORAGE.sh"
sudo chmod a+x "${DestMnt}/.config/ez/00-mount-EZSTORAGE.sh"

sudo cp -vL 01-expand-EZSTORAGE.sh "${DestMnt}/.config/ez/01-expand-EZSTORAGE.sh"
sudo chmod a+x "${DestMnt}/.config/ez/01-expand-EZSTORAGE.sh"

sudo cp -vL 02-setup-EZSTORAGE.sh "${DestMnt}/.config/ez/02-setup-EZSTORAGE.sh"
sudo chmod a+x "${DestMnt}/.config/ez/02-setup-EZSTORAGE.sh"

cat << EOF | sudo tee "${DestMnt}/.config/ez/ez2.sh" >/dev/null 2>&1
#!/bin/bash
# amber / pan4
ps ax | grep -ve 'ps ax' -e 'grep'| grep /usr/bin/emulationstation && reboot -f || true

# rocknix / uos
ps ax | grep -ve 'ps ax' -e 'grep'| grep emulationstation | grep -e '--no-splash' && reboot -f || true
exit 0
EOF

sudo chmod a+x "${DestMnt}/.config/ez/ez2.sh"

sayin cleanup mounts and img dev
sync
sudo umount ${Thislodev}p1
sudo umount ${ThisBootDev}
sudo umount ${ThisRootDev}

sync
sudo losetup -d ${Thislodev}
[[ "$BuildImgEnv" == "github" ]] && rm ${ThisImgName} || sayin keep ${ThisImgName}







