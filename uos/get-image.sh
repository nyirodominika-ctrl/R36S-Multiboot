#!/bin/bash

sudo apt install -y lynx
if [[ ! -f "${ThisImgName}" ]]
then
    [[ -f "${ThisImgName}.gz" ]] && rm ${ThisImgName}.gz
    [[ -f "${ThisImgName}" ]] && rm ${ThisImgName}
    thisdl=$(lynx -listonly -dump -nonumbers -unique_urls -hiddenlinks=listonly "https://github.com/RetroGFX/UnofficialOS/releases/latest" |grep RK3326-CLONE|grep img\.gz 2>/dev/null)
    echo $thisdl
    wget  --no-verbose --quiet -O${ThisImgName}.gz "$thisdl"
    gunzip -f ${ThisImgName}.gz
fi
