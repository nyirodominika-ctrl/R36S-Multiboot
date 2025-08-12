#!/bin/bash

set_con() {
  sudo chcon -h u:object_r:"$1":s0 $2
  sudo chcon u:object_r:"$1":s0 $2
}

set_perm() {
  sudo chmod $1 $2
}

set_owner() {
  sudo chown $1:$2 $3
}

ui_print() {
#   echo "ui_print $1" > "$OUTFD";
#   echo "ui_print" > "$OUTFD";
    sayin $1
}


say Post-installing andr36oid to ${imgname}


sayin installing gapps 


thisosdir=$(pwd)
ui_print "Extracting files"
TMP=$(pwd)/tmp
ZIP=$(pwd)/gapps.zip
[[ -d "$TMP" ]] && sudo rm -rf "$TMP" || true
mkdir -p $TMP
cd "$TMP"
#unzip -o "$ZIP"
rm -rf META-INF

# ui_print "Setting up environment"
# TOYBOX="${TMP}/toybox"
# sudo chmod +x "$TOYBOX"

# TOYS_PATH="${TMP}/bin"
# rm -rf "$TOYS_PATH";
# $TOYBOX install -d "$TOYS_PATH"
# for toy in $($TOYBOX); do
#   $TOYBOX ln -sf "$TOYBOX" "${TOYS_PATH}/${toy}"
# done
# PATH="${TOYS_PATH}:${PATH}"

SYSTEM_OUT="${DestRootMnt}/system"


cd $thisosdir

sudo rm -rf "$TMP"



sayin cleanup mounts and img dev
sync
sudo umount ${Thislodev}p1
sudo umount ${Thislodev}p2
sudo umount ${ThisBootDev}
sudo umount ${ThisRootDev}
#sudo umount ${ThisDataDev}

sync
sudo losetup -d ${Thislodev}

[[ "$BuildImgEnv" == "github" ]] && rm ${ThisImgName} || sayin keep ${ThisImgName}


# if [[ "$@" == *"andr36oid"* ]] 
# then



    sayin add android data partition
    sync
    sudo umount "${ImgBootMnt}"
    [[ -n "$AnDataSizeOverride" ]] && imgsize=$((imgsize + AnDataSizeOverride)) || imgsize=$((imgsize + 8192))
    sudo losetup -d $ImgLodev
    fallocate -l ${imgsize}MiB ${BuildingImgFullPath}
    sync
    sudo losetup -P ${ImgLodev} ${BuildingImgFullPath}
    sudo parted -s ${ImgLodev} resizepart 2 100%
    sudo mount ${ImgLodev}p1 "${ImgBootMnt}"
    [[ -n "$AnDataSizeOverride" ]] && npsz=$AnDataSizeOverride || npsz=8192
    sayin new $((npsz/1024))GiB partition
    newpart $npsz ext4 andata

# fi
