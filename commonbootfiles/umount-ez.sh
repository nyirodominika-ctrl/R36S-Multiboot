#!/bin/bash

AlreadyBooted=0
ps ax | grep -ve 'ps ax' -e 'grep'| grep /usr/bin/emulationstation && AlreadyBooted=1
ps ax | grep -ve 'ps ax' -e 'grep'| grep emulationstation | grep -e '--no-splash' && AlreadyBooted=1

[[ "$AlreadyBooted" -eq 1 ]] && systemctl stop emustation || true

while :
do
    paths="/EZSTORAGE /EZSTORAGE2 /roms /roms2 /storage/EZSTORAGE /storage/EZSTORAGE2 /storage/roms"
    for path in $paths
    do
        for mp in $(mount | grep "$path" |cut -d' ' -f3)
        do
            umount "${mp}" && echo ${mp} was stll mounted || continue
        done
    done
    for path in $paths
    do
        umount $path >/dev/null 2>&1
        umount $path >/dev/null 2>&1
        umount $path >/dev/null 2>&1
    done
    for path in $paths
    do
        mount | grep "$EZPath" >/dev/null 2>&1 && continue
        mount | grep "$EZ2Path" >/dev/null 2>&1 && continue
        mount | grep "$RomPath" >/dev/null 2>&1 && continue
    done

    break
done
exit 0