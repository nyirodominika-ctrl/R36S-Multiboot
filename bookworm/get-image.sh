#!/bin/bash

if [[ ! -f "$ThisImgName" ]]
then
    [[ -f "${ThisImgName}.xz" ]] && rm ${ThisImgName}.xz
    thisdl=https://github.com/R36S-Stuff/R36S-Armbian/releases/latest/download/armbian-r36s-${OsName}-xfce.img.xz
    wget  --no-verbose --quiet --no-check-certificate "$thisdl" -O${ThisImgName}.xz
    unxz -T0 --force --decompress ${ThisImgName}.xz
fi
