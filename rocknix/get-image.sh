#!/bin/bash

sudo apt install -y lynx
if [[ ! -f "${ThisImgName}" ]]
then
    [[ -f "${ThisImgName}.gz" ]] && rm ${ThisImgName}.gz
    [[ -f "${ThisImgName}" ]] && rm ${ThisImgName}
    ## Stable
    ROCKNIXdl=$(lynx -listonly -dump -nonumbers "https://github.com/ROCKNIX/distribution/releases/latest" |grep "ROCKNIX-RK3326.aarch64-.*-a.img.gz" 2>/dev/null)

    ## Nightly
    # tag=$(lynx -listonly -dump -nonumbers -unique_urls -hiddenlinks=listonly "https://github.com/ROCKNIX/distribution-nightly/releases" | grep "https://github.com/ROCKNIX/distribution-nightly/releases/tag/"|sort|tail -n1)
    # tag=${tag##*/}
    # date=$(echo ${tag}| sed 's|nightly\-||')
    # ROCKNIXdl=https://github.com/ROCKNIX/distribution-nightly/releases/download/${tag}/ROCKNIX-RK3326.aarch64-${date}-a.img.gz

    echo $ROCKNIXdl
    wget  --no-verbose --quiet -O${ThisImgName}.gz "$ROCKNIXdl"
    gunzip -f ${ThisImgName}.gz
fi
