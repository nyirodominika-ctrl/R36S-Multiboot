#!/bin/bash
ThisimgName=armbian.img
if [[ ! -f "armbian.img" ]]
then
    [[ -f "armbian.img.xz" ]] && rm armbian.img.xz
    armbiandl=https://dl.armbian.com/uefi-arm64/Noble_current_xfce
    wget  --no-verbose --quiet --no-check-certificate -Oarmbian.img.xz "$armbiandl"
    unxz --force --decompress armbian.img.xz
fi
