#!/bin/bash
sudo apt install -y lynx >/dev/null 2>&1
if [[ ! -f "${ThisImgName}" ]]
then
    [[ -f "${ThisImgName}.gz" ]] && rm ${ThisImgName}.gz

    tag=$(lynx -listonly -dump -nonumbers -unique_urls -hiddenlinks=listonly "https://github.com/Kegg1701/P4ELEC/releases" | grep "https://github.com/Kegg1701/P4ELEC/releases/tag/"|sort|tail -n1)
    tag=${tag##*/}
    thisdl=https://github.com/Kegg1701/P4ELEC/releases/download/${tag}/PAN4ELEC-RG351MP.aarch64-${tag}.img.gz
    echo $thisdl
    wget  --no-verbose --quiet -O${ThisImgName}.gz "$thisdl"
    gunzip -f ${ThisImgName}.gz
fi
