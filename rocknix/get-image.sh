#!/bin/bash
ThisimgName=rocknix.img

if [[ ! -f "${ThisimgName}" ]]
then
    [[ -f "${ThisimgName}.gz" ]] && rm ${ThisimgName}.gz
    [[ -f "${ThisimgName}" ]] && rm ${ThisimgName}
    ROCKNIXdl=$(lynx -listonly -dump -nonumbers "https://github.com/ROCKNIX/distribution/releases/latest" |grep "ROCKNIX-RK3326.aarch64-.*-a.img.gz" 2>/dev/null)
    echo $ROCKNIXdl
    wget -O${ThisimgName}.gz "$ROCKNIXdl"
    gunzip -f ${ThisimgName}.gz
fi