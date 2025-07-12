#!/bin/bash
OS=$1
OSRomsDir=$2
EZRomsDir=$3

debug=false
OsName=$OS

if [[ "$OsName" == "rocknix" ]] || [[ "$OsName" == "uos" ]]
then
    ttySpacing="\r\033[K\r==> "
    ttyEndChar="\r"
else
    ttySpacing="  "
    ttyEndChar="\n"
fi
#echo -ne "${ttySpacing}

# Exit if cant get root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, relaunching with sudo"
    exec sudo "$0" "$@"
    [[ $? -ne 0 ]] && exit 1
fi

if [[ "$4" = "debug" ]]
then
    debug=true
    echo "Debug mode enabled"
fi

if [[ "$debug" = true ]]
then
    [[ -z "$OS" ]] && OS=ark
    [[ -z "$OSRomsDir" ]] && OSRomsDir=/roms
    [[ -z "$EZRomsDir" ]] && EZRomsDir=/EZStorage
    echo "OS: $OS"
    echo "OSRomsDir: $OSRomsDir"
    echo "EZRomsDir: $EZRomsDir"
    FullEZRomsDir=$(pwd)/EZStorage_all
else
    [[ -z "$OS" || -z "$OSRomsDir" || -z "$EZRomsDir" ]] &&  exit 1
    FullEZRomsDir=$EZRomsDir/.DontModify/EZStorage_all
fi

# check if EZRomsDir exists
if [[ ! -d "$EZRomsDir" ]]
then
    echo "EZRomsDir does not exist: $EZRomsDir"
    exit 1
fi

# check if EZRomsDir is mounted
if ! grep $EZRomsDir /proc/mounts
then
    echo "EZRomsDir is not mounted: $EZRomsDir"
    exit 1
fi

# check if extraction was interrupted
if [[ -d "$FullEZRomsDir" ]] && [[ ! -f "$EZRomsDir/.DontModify/EZStorage.configured" ]]
then
    rm -rf $FullEZRomsDir
fi

# check if FullEZRomsDir exists
if [[ ! -d "$FullEZRomsDir" ]]
then
    echo -ne "${ttySpacing}First boot! Will take some time, be patient.${ttyEndChar}" >>/dev/tty1
    # create FullEZRomsDir if it does not exist
    echo "FullEZRomsDir does not exist: $FullEZRomsDir"
    echo "Creating FullEZRomsDir: $FullEZRomsDir"
    mkdir -p "$FullEZRomsDir"
    # use script directory as BootDir
    BootDir=$(dirname "$(readlink -f "$0")")
    if [[ ! -f "${BootDir}/EZStorage_all.tar" ]]
    then
        echo "EZStorage_all.tar not found in $BootDir"
        exit 1
    fi
    echo "Extracting EZStorage_all from boot device: $BootDir"
    tar --no-same-permissions --no-same-owner -xf "${BootDir}/EZStorage_all.tar" -C "$FullEZRomsDir" EZStorage_all --strip-components=1
    find "$FullEZRomsDir" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
        mkdir -p "${dir/$FullEZRomsDir/$EZRomsDir}"
    done
    for localbuildteststuff in bios gb 00_Music 00_Videos
    do
        rm -rf $EZRomsDir/$localbuildteststuff
        mv $FullEZRomsDir/$localbuildteststuff $EZRomsDir/$localbuildteststuff
        mkdir -p $FullEZRomsDir/$localbuildteststuff
    done
    touch $EZRomsDir/.DontModify/EZStorage.configured
    sync
    sleep 5
fi

Bind2RomsDir() {
    local EZRomDir="$1"
    local RomDir="$2"
    if [[ "$debug" = true ]]
    then
        echo "Would bind EZRomDir: $EZRomDir to RomDir: $RomDir"
        echo "[[ ! -d \"$EZRomDir\" ]] && mkdir -p \"$EZRomDir\""
        echo "[[ ! -d \"$RomDir\" ]] && mkdir -p \"$RomDir\""
        echo mount --bind \"$EZRomDir\" \"$RomDir\"
        echo
    else
        echo "Binding EZRomDir: $EZRomDir to RomDir: $RomDir"
        [[ ! -d "$EZRomDir" ]] && mkdir -p "$EZRomDir"
        [[ ! -d "$RomDir" ]] && mkdir -p "$RomDir"
        mount --bind "$EZRomDir" "$RomDir"
    fi
}


RomsDir=$OSRomsDir

[[ ! -d "$RomsDir" ]] && mkdir -p "$RomsDir"
# process mapped binds
for maptype in Music Videos
do
    for EZRomDir in $(find "$FullEZRomsDir" -type f -name "DO_NOT_USE.MappedTo-00_$maptype" -exec dirname {} \;)
    do
        EZRomDir=$(echo $EZRomDir|sed "s|$FullEZRomsDir|$EZRomsDir|g")
        [[  "$EZRomDir" == *"_${OS}_"* ]] && Bind2RomsDir "$EZRomsDir/00_$maptype" "$EZRomDir"
    done
done
# process binds
for EZRomDir in $(find "$FullEZRomsDir" -mindepth 1 -maxdepth 1 -type d)
do
    EZRomDir=$(echo $EZRomDir|sed "s|$FullEZRomsDir|$EZRomsDir|g")
    echo "Processing EZRomDir: $(basename $EZRomDir)"
    if [[ "$(basename $EZRomDir)" == "_"* ]]
    then
        for RomDirName in $(find "$FullEZRomsDir/$(basename $EZRomDir)" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
        do
            [[ "$EZRomDir" == *"_${OS}_"* ]] && Bind2RomsDir "$EZRomDir/$RomDirName" "$RomsDir/$RomDirName"
            [[ ! "$EZRomDir" == *"_${OS}_"* ]] && [[ ! -d "$EZRomDir/$RomDirName" ]] && [[ "$debug" = false ]] && mkdir -p "$EZRomDir/$RomDirName"
        done
    else
        Bind2RomsDir "$EZRomDir" "$RomsDir/$(basename $EZRomDir)"
    fi
done
