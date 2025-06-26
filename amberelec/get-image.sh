#!/bin/bash
sudo apt install -y lynx >/dev/null 2>&1
if [[ ! -f "${ThisImgName}" ]]
then
    [[ -f "${ThisImgName}.gz" ]] && rm ${ThisImgName}.gz
    thisdl=$(lynx -listonly -dump -nonumbers "https://github.com/AmberELEC/AmberELEC-prerelease/releases" | grep "AmberELEC-RG351MP.aarch64-prerelease-.*.img.gz"|sort|tail -n1)
    echo $ROCKNIXdl
    wget  --no-verbose --quiet -O${ThisImgName}.gz "$thisdl"
    gunzip -f ${ThisImgName}.gz
fi