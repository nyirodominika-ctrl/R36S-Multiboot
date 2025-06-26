#!/bin/bash

sudo apt install -y lynx
if [[ ! -f "${ThisImgName}" ]]
then
    [[ -f "${ThisImgName}.gz" ]] && rm ${ThisImgName}.gz
    [[ -f "${ThisImgName}" ]] && rm ${ThisImgName}
    ROCKNIXdl=$(lynx -listonly -dump -nonumbers "https://github.com/ROCKNIX/distribution/releases/latest" |grep "ROCKNIX-RK3326.aarch64-.*-a.img.gz" 2>/dev/null)
    echo $ROCKNIXdl
    wget  --no-verbose --quiet -O${ThisImgName}.gz "$ROCKNIXdl"
    gunzip -f ${ThisImgName}.gz
fi
