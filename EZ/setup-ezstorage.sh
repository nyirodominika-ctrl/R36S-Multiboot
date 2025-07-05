#!/bin/bash
OS=$1
OSRomsDir=$2
EZRomsDir=$3

debug=false

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
if [[ ! -d "$EZRomsDir" ]]
then
    echo "EZRomsDir is not mounted: $EZRomsDir"
    exit 1
fi

movefile() {
    local src="$1"
    local dest="$1"
    dest=$(echo "$dest" | sed "s|$FullEZRomsDir|$EZRomsDir|g")
    mv "$src" "$dest"
}

makedir() {
    local dest="$1"
    dest=$(echo "$dest" | sed "s|$FullEZRomsDir|$EZRomsDir|g")
    echo
    mkdir -p "$dest"
}

# check if FullEZRomsDir exists
if [[ ! -d "$FullEZRomsDir" ]]
then
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
    find "$FullEZRomsDir" -type d | while read -r dir; do
        # Replace $FullEZRomsDir with your target base directory, e.g., $EZRomsDir/SomeTarget
        target_dir="${dir/$FullEZRomsDir/$EZRomsDir}"
        mkdir -p "$target_dir"
    done
    # move files recursively from FullEZRomsDir to EZRomsDir 
    echo "Moving files from FullEZRomsDir to EZRomsDir"
    find "$FullEZRomsDir" -type f | while read -r file; do
        if [[ "$file" == *"DO_NOT_USE.MappedTo"* ]] 
        then
            echo "Skipping mapped file: $file"
            continue
        fi
        dest=$(echo "$file" | sed "s|$FullEZRomsDir|$EZRomsDir|g")
        mv "$file" "$dest"
    done

    sync
    sleep 5
fi

Bind2OSRomsDir() {
    local EZRomDir="$1"
    local OSRomDir="$2"
    if [[ "$debug" = true ]]
    then
        echo "Would bind EZRomDir: $EZRomDir to OSRomDir: $OSRomDir"
        echo "[[ ! -d \"$EZRomDir\" ]] && mkdir -p \"$EZRomDir\""
        echo "[[ ! -d \"$OSRomDir\" ]] && mkdir -p \"$OSRomDir\""
        echo mount --bind \"$EZRomDir\" \"$OSRomDir\"
        echo
    else
        echo "Binding EZRomDir: $EZRomDir to OSRomDir: $OSRomDir"
        [[ ! -d "$EZRomDir" ]] && mkdir -p "$EZRomDir"
        [[ ! -d "$OSRomDir" ]] && mkdir -p "$OSRomDir"
        mount --bind "$EZRomDir" "$OSRomDir"
    fi

}

# if [[ "$OS" = "rocknix" ]]
# then
# 	mount --bind /storage/games-internal /storage/games-external
# 	mount --bind /storage/games-external/roms /storage/roms
#     #OSRomsDir=/storage/roms
# fi

#process mapped binds
for maptype in Music Videos
do
    for EZRomDir in $(find "$FullEZRomsDir" -type f -name "DO_NOT_USE.MappedTo-00_$maptype" -exec dirname {} \;)
    do
        EZRomDir=$(echo $EZRomDir|sed "s|$FullEZRomsDir|$EZRomsDir|g")
        [[  "$EZRomDir" == *"_${OS}_"* ]] && Bind2OSRomsDir "$EZRomsDir/00_$maptype" "$EZRomDir"
    done
done

for EZRomDir in $(find "$FullEZRomsDir" -mindepth 1 -maxdepth 1 -type d)
do
    EZRomDir=$(echo $EZRomDir|sed "s|$FullEZRomsDir|$EZRomsDir|g")
    echo "Processing EZRomDir: $(basename $EZRomDir)"
    if [[  "$(basename $EZRomDir)" == "_"* ]]; then
        for RomDirName in $(find "$FullEZRomsDir/$(basename $EZRomDir)" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
        do
            [[ "$EZRomDir" == *"_${OS}_"* ]] && Bind2OSRomsDir "$EZRomDir/$RomDirName" "$OSRomsDir/$RomDirName"
            [[ ! "$EZRomDir" == *"_${OS}_"* ]] && [[ ! -d "$EZRomDir/$RomDirName" ]] && [[ "$debug" = false ]] && mkdir -p "$EZRomDir/$RomDirName"
        done
    else
        Bind2OSRomsDir "$EZRomDir" "$OSRomsDir/$(basename $EZRomDir)"
    fi
done

exit 0