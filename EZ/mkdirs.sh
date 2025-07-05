#!/bin/bash

set -e

DEBUG=False # Set to true to enable debug messages

OSes=("amberelec" "ark" "pan4elec" "rocknix" "uos")
IgnoreSpecialDirs=("tools" "themes" "savestates" "gamedata" "build" "update" "updates" "backup")
MusicDirs=("music" "BGM" "bgmusic")
VideoDirs=("videos" "video" "movies" "mplayer")
SkipCommonDirs=()

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

EZ="$SCRIPT_DIR/EZStorage_all"
# echo $EZ
# exit

function debug_msg() {
    if [ "$DEBUG" = true ]; then
        echo "DEBUG: $1"
    fi
}

function dir_exists() {
    [ -d "$1" ]
}

function is_music_dir() {
    local dir="$1"
    for music in "${MusicDirs[@]}"; do
        [[ "${music,,}" == "${dir,,}" ]] && return 0
    done
    return 1
}

function is_video_dir() {
    local dir="$1"
    for video in "${VideoDirs[@]}"; do
        [[ "${video,,}" == "${dir,,}" ]] && return 0
    done
    return 1
}

function ignore_common_dir() {
    local dir="$1"
    for ignore in "${IgnoreSpecialDirs[@]}"; do
        [[ "${ignore,,}" == "${dir,,}" ]] && return 0
    done
    return 1
}

function skip_common_dir() {
    local dir="$1"
    for skip in "${SkipCommonDirs[@]}"; do
        [[ "${skip,,}" == "${dir,,}" ]] && return 0
    done
    return 1
}

function get_oses_that_contain() {
    local dir="$1"
    local found=()
    for os in "${OSes[@]}"; do
        if dir_exists "$SCRIPT_DIR/${os}-freshroms/$dir"; then
            found+=("$os")
        fi
    done
    echo "${found[@]}"
}

function how_many_oses_contain() {
    local dir="$1"
    local oses
    oses=($(get_oses_that_contain "$dir"))
    echo "${#oses[@]}"
}

function get_os_list_that_contain() {
    local dir="$1"
    local oses
    oses=($(get_oses_that_contain "$dir"))
    local list=""
    for os in "${oses[@]}"; do
        if [ -n "$list" ]; then
            list+="_"
        fi
        list+="$os"
    done
    echo "$list"
}

for os in "${OSes[@]}"; do
    roms_dir="$SCRIPT_DIR/${os}-freshroms"
    rm -rf "$roms_dir"
    mkdir -p "$roms_dir"
    tar -xf "$SCRIPT_DIR/00_tars/${os}-freshroms.tar" -C "$roms_dir"
    #find "$roms_dir" -type f -exec rm -f {} \; 2>/dev/null || true
    debug_msg "Created directory: $roms_dir"

done

# Remove EZ dir if exists
if dir_exists "$SCRIPT_DIR/EZ"; then
    rm -rf "$SCRIPT_DIR/EZ"
fi

# Main loop
for os in "${OSes[@]}"; do
    roms_dir="$SCRIPT_DIR/${os}-freshroms"
    [ -d "$roms_dir" ] || continue
    for rom_dir in "$roms_dir"/*; do
        [ -d "$rom_dir" ] || continue
        this_rom_dir="$(basename "$rom_dir")"

        if skip_common_dir "$this_rom_dir"; then
            debug_msg "skipping processed common dir: $this_rom_dir"
            continue
        elif ignore_common_dir "$this_rom_dir"; then
            debug_msg "ignoring os specific dir: $this_rom_dir"
            dir_to_create="$EZ/_1_${os}_only/$this_rom_dir"
        elif [ "$(how_many_oses_contain "$this_rom_dir")" -eq "${#OSes[@]}" ]; then
            debug_msg "creating $this_rom_dir in common rom dir"
            dir_to_create="$EZ/$this_rom_dir"
            SkipCommonDirs+=("$this_rom_dir")
        elif [ "$(how_many_oses_contain "$this_rom_dir")" -eq 1 ]; then
            debug_msg "creating $this_rom_dir in _1_${os}_only"
            dir_to_create="$EZ/_1_${os}_only/$this_rom_dir"
        elif [ "$(how_many_oses_contain "$this_rom_dir")" -gt 1 ]; then
            os_list="$(get_os_list_that_contain "$this_rom_dir")"
            debug_msg "creating $this_rom_dir in _$(how_many_oses_contain "$this_rom_dir")_${os_list}_only"
            dir_to_create="$EZ/_$(how_many_oses_contain "$this_rom_dir")_${os_list}_only/$this_rom_dir"
        fi

        mkdir -p "$dir_to_create"
        # echo "${roms_dir}/$this_rom_dir"
        # echo "${dir_to_create}"
        echo cp -vr "${roms_dir}/$this_rom_dir/*" "${dir_to_create}" || true
        rsync -avhW --no-compress --progress "${roms_dir}/$this_rom_dir/" "${dir_to_create}/"

        if is_music_dir "$this_rom_dir"; then
            echo -e "This is a music directory.\nit is mapped to 00_Music" > "$dir_to_create/DO_NOT_USE.MappedTo-00_Music"
            [ -d "$EZ/00_Music" ] || mkdir -p "$EZ/00_Music"
        fi
        if is_video_dir "$this_rom_dir"; then
            echo -e "This is a video directory.\nit is mapped to 00_Videos" > "$dir_to_create/DO_NOT_USE.MappedTo-00_Videos"
            [ -d "$EZ/00_Videos" ] || mkdir -p "$EZ/00_Videos"
        fi
    done
done
