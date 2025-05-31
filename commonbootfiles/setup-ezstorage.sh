#!/bin/bash

[[ -z "$1" ]] && exit

if [[ "$1" = "ark" ]]
then
	RomDir=/roms
	EZRomDir=/roms
	[[ ! -d ${RomDir}/advision ]] && mkdir -p ${RomDir}/advision
	[[ ! -d ${EZRomDir}/roms/00-ark-only/advision ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/advision
	mount --bind ${EZRomDir}/roms/00-ark-only/advision ${RomDir}/advision
	[[ ! -d ${RomDir}/alg ]] && mkdir -p ${RomDir}/alg
	[[ ! -d ${EZRomDir}/roms/00-ark-only/alg ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/alg
	mount --bind ${EZRomDir}/roms/00-ark-only/alg ${RomDir}/alg
	[[ ! -d ${RomDir}/apple2 ]] && mkdir -p ${RomDir}/apple2
	[[ ! -d ${EZRomDir}/roms/00-ark-only/apple2 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/apple2
	mount --bind ${EZRomDir}/roms/00-ark-only/apple2 ${RomDir}/apple2
	[[ ! -d ${RomDir}/astrocde ]] && mkdir -p ${RomDir}/astrocde
	[[ ! -d ${EZRomDir}/roms/00-ark-only/astrocde ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/astrocde
	mount --bind ${EZRomDir}/roms/00-ark-only/astrocde ${RomDir}/astrocde
	[[ ! -d ${RomDir}/atarixegs ]] && mkdir -p ${RomDir}/atarixegs
	[[ ! -d ${EZRomDir}/roms/00-ark-only/atarixegs ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/atarixegs
	mount --bind ${EZRomDir}/roms/00-ark-only/atarixegs ${RomDir}/atarixegs
	[[ ! -d ${RomDir}/backup ]] && mkdir -p ${RomDir}/backup
	[[ ! -d ${EZRomDir}/roms/00-ark-only/backup ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/backup
	mount --bind ${EZRomDir}/roms/00-ark-only/backup ${RomDir}/backup
	[[ ! -d ${RomDir}/bbcmicro ]] && mkdir -p ${RomDir}/bbcmicro
	[[ ! -d ${EZRomDir}/roms/00-ark-only/bbcmicro ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/bbcmicro
	mount --bind ${EZRomDir}/roms/00-ark-only/bbcmicro ${RomDir}/bbcmicro
	[[ ! -d ${RomDir}/bgmusic ]] && mkdir -p ${RomDir}/bgmusic
	[[ ! -d ${EZRomDir}/roms/00-ark-only/bgmusic ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/bgmusic
	mount --bind ${EZRomDir}/roms/00-ark-only/bgmusic ${RomDir}/bgmusic
	[[ ! -d ${RomDir}/bios ]] && mkdir -p ${RomDir}/bios
	[[ ! -d ${EZRomDir}/roms/00-ark-only/bios ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/bios
	mount --bind ${EZRomDir}/roms/00-ark-only/bios ${RomDir}/bios
	[[ ! -d ${RomDir}/cavestory ]] && mkdir -p ${RomDir}/cavestory
	[[ ! -d ${EZRomDir}/roms/00-ark-only/cavestory ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/cavestory
	mount --bind ${EZRomDir}/roms/00-ark-only/cavestory ${RomDir}/cavestory
	[[ ! -d ${RomDir}/coco3 ]] && mkdir -p ${RomDir}/coco3
	[[ ! -d ${EZRomDir}/roms/00-ark-only/coco3 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/coco3
	mount --bind ${EZRomDir}/roms/00-ark-only/coco3 ${RomDir}/coco3
	[[ ! -d ${RomDir}/dos ]] && mkdir -p ${RomDir}/dos
	[[ ! -d ${EZRomDir}/roms/00-ark-only/dos ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/dos
	mount --bind ${EZRomDir}/roms/00-ark-only/dos ${RomDir}/dos
	[[ ! -d ${RomDir}/enterprise ]] && mkdir -p ${RomDir}/enterprise
	[[ ! -d ${EZRomDir}/roms/00-ark-only/enterprise ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/enterprise
	mount --bind ${EZRomDir}/roms/00-ark-only/enterprise ${RomDir}/enterprise
	[[ ! -d ${RomDir}/gx4000 ]] && mkdir -p ${RomDir}/gx4000
	[[ ! -d ${EZRomDir}/roms/00-ark-only/gx4000 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/gx4000
	mount --bind ${EZRomDir}/roms/00-ark-only/gx4000 ${RomDir}/gx4000
	[[ ! -d ${RomDir}/launchimages ]] && mkdir -p ${RomDir}/launchimages
	[[ ! -d ${EZRomDir}/roms/00-ark-only/launchimages ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/launchimages
	mount --bind ${EZRomDir}/roms/00-ark-only/launchimages ${RomDir}/launchimages
	[[ ! -d ${RomDir}/love2d ]] && mkdir -p ${RomDir}/love2d
	[[ ! -d ${EZRomDir}/roms/00-ark-only/love2d ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/love2d
	mount --bind ${EZRomDir}/roms/00-ark-only/love2d ${RomDir}/love2d
	[[ ! -d ${RomDir}/lowresnx ]] && mkdir -p ${RomDir}/lowresnx
	[[ ! -d ${EZRomDir}/roms/00-ark-only/lowresnx ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/lowresnx
	mount --bind ${EZRomDir}/roms/00-ark-only/lowresnx ${RomDir}/lowresnx
	[[ ! -d ${RomDir}/mame2003 ]] && mkdir -p ${RomDir}/mame2003
	[[ ! -d ${EZRomDir}/roms/00-ark-only/mame2003 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/mame2003
	mount --bind ${EZRomDir}/roms/00-ark-only/mame2003 ${RomDir}/mame2003
	[[ ! -d ${RomDir}/movies ]] && mkdir -p ${RomDir}/movies
	[[ ! -d ${EZRomDir}/roms/00-ark-only/movies ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/movies
	mount --bind ${EZRomDir}/roms/00-ark-only/movies ${RomDir}/movies
	[[ ! -d ${RomDir}/msumd ]] && mkdir -p ${RomDir}/msumd
	[[ ! -d ${EZRomDir}/roms/00-ark-only/msumd ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/msumd
	mount --bind ${EZRomDir}/roms/00-ark-only/msumd ${RomDir}/msumd
	[[ ! -d ${RomDir}/mv ]] && mkdir -p ${RomDir}/mv
	[[ ! -d ${EZRomDir}/roms/00-ark-only/mv ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/mv
	mount --bind ${EZRomDir}/roms/00-ark-only/mv ${RomDir}/mv
	[[ ! -d ${RomDir}/n64dd ]] && mkdir -p ${RomDir}/n64dd
	[[ ! -d ${EZRomDir}/roms/00-ark-only/n64dd ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/n64dd
	mount --bind ${EZRomDir}/roms/00-ark-only/n64dd ${RomDir}/n64dd
	[[ ! -d ${RomDir}/neogeocd ]] && mkdir -p ${RomDir}/neogeocd
	[[ ! -d ${EZRomDir}/roms/00-ark-only/neogeocd ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/neogeocd
	mount --bind ${EZRomDir}/roms/00-ark-only/neogeocd ${RomDir}/neogeocd
	[[ ! -d ${RomDir}/odyssey2 ]] && mkdir -p ${RomDir}/odyssey2
	[[ ! -d ${EZRomDir}/roms/00-ark-only/odyssey2 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/odyssey2
	mount --bind ${EZRomDir}/roms/00-ark-only/odyssey2 ${RomDir}/odyssey2
	[[ ! -d ${RomDir}/onscripter ]] && mkdir -p ${RomDir}/onscripter
	[[ ! -d ${EZRomDir}/roms/00-ark-only/onscripter ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/onscripter
	mount --bind ${EZRomDir}/roms/00-ark-only/onscripter ${RomDir}/onscripter
	[[ ! -d ${RomDir}/pico ]] && mkdir -p ${RomDir}/pico
	[[ ! -d ${EZRomDir}/roms/00-ark-only/pico ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/pico
	mount --bind ${EZRomDir}/roms/00-ark-only/pico ${RomDir}/pico
	[[ ! -d ${RomDir}/piece ]] && mkdir -p ${RomDir}/piece
	[[ ! -d ${EZRomDir}/roms/00-ark-only/piece ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/piece
	mount --bind ${EZRomDir}/roms/00-ark-only/piece ${RomDir}/piece
	[[ ! -d ${RomDir}/pokemonmini ]] && mkdir -p ${RomDir}/pokemonmini
	[[ ! -d ${EZRomDir}/roms/00-ark-only/pokemonmini ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/pokemonmini
	mount --bind ${EZRomDir}/roms/00-ark-only/pokemonmini ${RomDir}/pokemonmini
	[[ ! -d ${RomDir}/puzzlescript ]] && mkdir -p ${RomDir}/puzzlescript
	[[ ! -d ${EZRomDir}/roms/00-ark-only/puzzlescript ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/puzzlescript
	mount --bind ${EZRomDir}/roms/00-ark-only/puzzlescript ${RomDir}/puzzlescript
	[[ ! -d ${RomDir}/scummvm ]] && mkdir -p ${RomDir}/scummvm
	[[ ! -d ${EZRomDir}/roms/00-ark-only/scummvm ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/scummvm
	mount --bind ${EZRomDir}/roms/00-ark-only/scummvm ${RomDir}/scummvm
	[[ ! -d ${RomDir}/sgb ]] && mkdir -p ${RomDir}/sgb
	[[ ! -d ${EZRomDir}/roms/00-ark-only/sgb ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/sgb
	mount --bind ${EZRomDir}/roms/00-ark-only/sgb ${RomDir}/sgb
	[[ ! -d ${RomDir}/snes-hacks ]] && mkdir -p ${RomDir}/snes-hacks
	[[ ! -d ${EZRomDir}/roms/00-ark-only/snes-hacks ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/snes-hacks
	mount --bind ${EZRomDir}/roms/00-ark-only/snes-hacks ${RomDir}/snes-hacks
	[[ ! -d ${RomDir}/solarus ]] && mkdir -p ${RomDir}/solarus
	[[ ! -d ${EZRomDir}/roms/00-ark-only/solarus ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/solarus
	mount --bind ${EZRomDir}/roms/00-ark-only/solarus ${RomDir}/solarus
	[[ ! -d ${RomDir}/supergrafx ]] && mkdir -p ${RomDir}/supergrafx
	[[ ! -d ${EZRomDir}/roms/00-ark-only/supergrafx ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/supergrafx
	mount --bind ${EZRomDir}/roms/00-ark-only/supergrafx ${RomDir}/supergrafx
	[[ ! -d ${RomDir}/themes ]] && mkdir -p ${RomDir}/themes
	[[ ! -d ${EZRomDir}/roms/00-ark-only/themes ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/themes
	mount --bind ${EZRomDir}/roms/00-ark-only/themes ${RomDir}/themes
	[[ ! -d ${RomDir}/thomson ]] && mkdir -p ${RomDir}/thomson
	[[ ! -d ${EZRomDir}/roms/00-ark-only/thomson ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/thomson
	mount --bind ${EZRomDir}/roms/00-ark-only/thomson ${RomDir}/thomson
	[[ ! -d ${RomDir}/ti99 ]] && mkdir -p ${RomDir}/ti99
	[[ ! -d ${EZRomDir}/roms/00-ark-only/ti99 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/ti99
	mount --bind ${EZRomDir}/roms/00-ark-only/ti99 ${RomDir}/ti99
	[[ ! -d ${RomDir}/tic80 ]] && mkdir -p ${RomDir}/tic80
	[[ ! -d ${EZRomDir}/roms/00-ark-only/tic80 ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/tic80
	mount --bind ${EZRomDir}/roms/00-ark-only/tic80 ${RomDir}/tic80
	[[ ! -d ${RomDir}/tools ]] && mkdir -p ${RomDir}/tools
	[[ ! -d ${EZRomDir}/roms/00-ark-only/tools ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/tools
	mount --bind ${EZRomDir}/roms/00-ark-only/tools ${RomDir}/tools
	[[ ! -d ${RomDir}/turbografx ]] && mkdir -p ${RomDir}/turbografx
	[[ ! -d ${EZRomDir}/roms/00-ark-only/turbografx ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/turbografx
	mount --bind ${EZRomDir}/roms/00-ark-only/turbografx ${RomDir}/turbografx
	[[ ! -d ${RomDir}/turbografxcd ]] && mkdir -p ${RomDir}/turbografxcd
	[[ ! -d ${EZRomDir}/roms/00-ark-only/turbografxcd ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/turbografxcd
	mount --bind ${EZRomDir}/roms/00-ark-only/turbografxcd ${RomDir}/turbografxcd
	[[ ! -d ${RomDir}/tvc ]] && mkdir -p ${RomDir}/tvc
	[[ ! -d ${EZRomDir}/roms/00-ark-only/tvc ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/tvc
	mount --bind ${EZRomDir}/roms/00-ark-only/tvc ${RomDir}/tvc
	[[ ! -d ${RomDir}/videos ]] && mkdir -p ${RomDir}/videos
	[[ ! -d ${EZRomDir}/roms/00-ark-only/videos ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/videos
	mount --bind ${EZRomDir}/roms/00-ark-only/videos ${RomDir}/videos
	[[ ! -d ${RomDir}/vmac ]] && mkdir -p ${RomDir}/vmac
	[[ ! -d ${EZRomDir}/roms/00-ark-only/vmac ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/vmac
	mount --bind ${EZRomDir}/roms/00-ark-only/vmac ${RomDir}/vmac
	[[ ! -d ${RomDir}/vmu ]] && mkdir -p ${RomDir}/vmu
	[[ ! -d ${EZRomDir}/roms/00-ark-only/vmu ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/vmu
	mount --bind ${EZRomDir}/roms/00-ark-only/vmu ${RomDir}/vmu
	[[ ! -d ${RomDir}/wolf ]] && mkdir -p ${RomDir}/wolf
	[[ ! -d ${EZRomDir}/roms/00-ark-only/wolf ]] && mkdir -p ${EZRomDir}/roms/00-ark-only/wolf
	mount --bind ${EZRomDir}/roms/00-ark-only/wolf ${RomDir}/wolf
fi

if [[ "$1" = "rocknix" ]]
then
	mount --bind /storage/games-internal /storage/games-external 
	mount --bind /storage/games-external/roms /storage/roms
	RomDir=/storage/games-internal/roms
	EZRomDir=/storage/EZSTORAGE
	[[ ! -d ${RomDir}/bezels ]] && mkdir -p ${RomDir}/bezels
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/bezels ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/bezels
	mount --bind ${EZRomDir}/roms/00-rocknix-only/bezels ${RomDir}/bezels
	[[ ! -d ${RomDir}/bios ]] && mkdir -p ${RomDir}/bios
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/bios ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/bios
	mount --bind ${EZRomDir}/roms/00-rocknix-only/bios ${RomDir}/bios
	[[ ! -d ${RomDir}/cdi ]] && mkdir -p ${RomDir}/cdi
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/cdi ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/cdi
	mount --bind ${EZRomDir}/roms/00-rocknix-only/cdi ${RomDir}/cdi
	[[ ! -d ${RomDir}/chip-8 ]] && mkdir -p ${RomDir}/chip-8
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/chip-8 ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/chip-8
	mount --bind ${EZRomDir}/roms/00-rocknix-only/chip-8 ${RomDir}/chip-8
	[[ ! -d ${RomDir}/fbneo ]] && mkdir -p ${RomDir}/fbneo
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/fbneo ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/fbneo
	mount --bind ${EZRomDir}/roms/00-rocknix-only/fbneo ${RomDir}/fbneo
	[[ ! -d ${RomDir}/gamegearh ]] && mkdir -p ${RomDir}/gamegearh
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/gamegearh ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/gamegearh
	mount --bind ${EZRomDir}/roms/00-rocknix-only/gamegearh ${RomDir}/gamegearh
	[[ ! -d ${RomDir}/gbah ]] && mkdir -p ${RomDir}/gbah
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/gbah ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/gbah
	mount --bind ${EZRomDir}/roms/00-rocknix-only/gbah ${RomDir}/gbah
	[[ ! -d ${RomDir}/gbav ]] && mkdir -p ${RomDir}/gbav
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/gbav ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/gbav
	mount --bind ${EZRomDir}/roms/00-rocknix-only/gbav ${RomDir}/gbav
	[[ ! -d ${RomDir}/gbch ]] && mkdir -p ${RomDir}/gbch
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/gbch ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/gbch
	mount --bind ${EZRomDir}/roms/00-rocknix-only/gbch ${RomDir}/gbch
	[[ ! -d ${RomDir}/gbh ]] && mkdir -p ${RomDir}/gbh
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/gbh ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/gbh
	mount --bind ${EZRomDir}/roms/00-rocknix-only/gbh ${RomDir}/gbh
	[[ ! -d ${RomDir}/genh ]] && mkdir -p ${RomDir}/genh
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/genh ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/genh
	mount --bind ${EZRomDir}/roms/00-rocknix-only/genh ${RomDir}/genh
	[[ ! -d ${RomDir}/mac ]] && mkdir -p ${RomDir}/mac
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/mac ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/mac
	mount --bind ${EZRomDir}/roms/00-rocknix-only/mac ${RomDir}/mac
	[[ ! -d ${RomDir}/megacd ]] && mkdir -p ${RomDir}/megacd
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/megacd ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/megacd
	mount --bind ${EZRomDir}/roms/00-rocknix-only/megacd ${RomDir}/megacd
	[[ ! -d ${RomDir}/megadrive-japan ]] && mkdir -p ${RomDir}/megadrive-japan
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/megadrive-japan ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/megadrive-japan
	mount --bind ${EZRomDir}/roms/00-rocknix-only/megadrive-japan ${RomDir}/megadrive-japan
	[[ ! -d ${RomDir}/megadriveh ]] && mkdir -p ${RomDir}/megadriveh
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/megadriveh ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/megadriveh
	mount --bind ${EZRomDir}/roms/00-rocknix-only/megadriveh ${RomDir}/megadriveh
	[[ ! -d ${RomDir}/moonlight ]] && mkdir -p ${RomDir}/moonlight
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/moonlight ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/moonlight
	mount --bind ${EZRomDir}/roms/00-rocknix-only/moonlight ${RomDir}/moonlight
	[[ ! -d ${RomDir}/moto ]] && mkdir -p ${RomDir}/moto
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/moto ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/moto
	mount --bind ${EZRomDir}/roms/00-rocknix-only/moto ${RomDir}/moto
	[[ ! -d ${RomDir}/mplayer ]] && mkdir -p ${RomDir}/mplayer
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/mplayer ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/mplayer
	mount --bind ${EZRomDir}/roms/00-rocknix-only/mplayer ${RomDir}/mplayer
	[[ ! -d ${RomDir}/music ]] && mkdir -p ${RomDir}/music
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/music ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/music
	mount --bind ${EZRomDir}/roms/00-rocknix-only/music ${RomDir}/music
	[[ ! -d ${RomDir}/neocd ]] && mkdir -p ${RomDir}/neocd
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/neocd ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/neocd
	mount --bind ${EZRomDir}/roms/00-rocknix-only/neocd ${RomDir}/neocd
	[[ ! -d ${RomDir}/nesh ]] && mkdir -p ${RomDir}/nesh
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/nesh ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/nesh
	mount --bind ${EZRomDir}/roms/00-rocknix-only/nesh ${RomDir}/nesh
	[[ ! -d ${RomDir}/odyssey ]] && mkdir -p ${RomDir}/odyssey
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/odyssey ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/odyssey
	mount --bind ${EZRomDir}/roms/00-rocknix-only/odyssey ${RomDir}/odyssey
	[[ ! -d ${RomDir}/pc ]] && mkdir -p ${RomDir}/pc
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/pc ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/pc
	mount --bind ${EZRomDir}/roms/00-rocknix-only/pc ${RomDir}/pc
	[[ ! -d ${RomDir}/pc88 ]] && mkdir -p ${RomDir}/pc88
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/pc88 ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/pc88
	mount --bind ${EZRomDir}/roms/00-rocknix-only/pc88 ${RomDir}/pc88
	[[ ! -d ${RomDir}/pet ]] && mkdir -p ${RomDir}/pet
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/pet ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/pet
	mount --bind ${EZRomDir}/roms/00-rocknix-only/pet ${RomDir}/pet
	[[ ! -d ${RomDir}/pokemini ]] && mkdir -p ${RomDir}/pokemini
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/pokemini ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/pokemini
	mount --bind ${EZRomDir}/roms/00-rocknix-only/pokemini ${RomDir}/pokemini
	[[ ! -d ${RomDir}/savestates ]] && mkdir -p ${RomDir}/savestates
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/savestates ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/savestates
	mount --bind ${EZRomDir}/roms/00-rocknix-only/savestates ${RomDir}/savestates
	[[ ! -d ${RomDir}/screenshots ]] && mkdir -p ${RomDir}/screenshots
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/screenshots ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/screenshots
	mount --bind ${EZRomDir}/roms/00-rocknix-only/screenshots ${RomDir}/screenshots
	[[ ! -d ${RomDir}/sgfx ]] && mkdir -p ${RomDir}/sgfx
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/sgfx ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/sgfx
	mount --bind ${EZRomDir}/roms/00-rocknix-only/sgfx ${RomDir}/sgfx
	[[ ! -d ${RomDir}/snesh ]] && mkdir -p ${RomDir}/snesh
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/snesh ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/snesh
	mount --bind ${EZRomDir}/roms/00-rocknix-only/snesh ${RomDir}/snesh
	[[ ! -d ${RomDir}/st-v ]] && mkdir -p ${RomDir}/st-v
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/st-v ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/st-v
	mount --bind ${EZRomDir}/roms/00-rocknix-only/st-v ${RomDir}/st-v
	[[ ! -d ${RomDir}/tg16 ]] && mkdir -p ${RomDir}/tg16
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/tg16 ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/tg16
	mount --bind ${EZRomDir}/roms/00-rocknix-only/tg16 ${RomDir}/tg16
	[[ ! -d ${RomDir}/tg16cd ]] && mkdir -p ${RomDir}/tg16cd
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/tg16cd ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/tg16cd
	mount --bind ${EZRomDir}/roms/00-rocknix-only/tg16cd ${RomDir}/tg16cd
	[[ ! -d ${RomDir}/themes ]] && mkdir -p ${RomDir}/themes
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/themes ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/themes
	mount --bind ${EZRomDir}/roms/00-rocknix-only/themes ${RomDir}/themes
	[[ ! -d ${RomDir}/tic-80 ]] && mkdir -p ${RomDir}/tic-80
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/tic-80 ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/tic-80
	mount --bind ${EZRomDir}/roms/00-rocknix-only/tic-80 ${RomDir}/tic-80
	[[ ! -d ${RomDir}/videopac ]] && mkdir -p ${RomDir}/videopac
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/videopac ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/videopac
	mount --bind ${EZRomDir}/roms/00-rocknix-only/videopac ${RomDir}/videopac
	[[ ! -d ${RomDir}/windows ]] && mkdir -p ${RomDir}/windows
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/windows ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/windows
	mount --bind ${EZRomDir}/roms/00-rocknix-only/windows ${RomDir}/windows
	[[ ! -d ${RomDir}/zmachine ]] && mkdir -p ${RomDir}/zmachine
	[[ ! -d ${EZRomDir}/roms/00-rocknix-only/zmachine ]] && mkdir -p ${EZRomDir}/roms/00-rocknix-only/zmachine
	mount --bind ${EZRomDir}/roms/00-rocknix-only/zmachine ${RomDir}/zmachine
fi


[[ ! -d ${RomDir}/3do ]] && mkdir -p ${RomDir}/3do
[[ ! -d ${EZRomDir}/roms/3do ]] && mkdir -p ${EZRomDir}/roms/3do
mount --bind ${EZRomDir}/roms/3do ${RomDir}/3do
[[ ! -d ${RomDir}/amiga ]] && mkdir -p ${RomDir}/amiga
[[ ! -d ${EZRomDir}/roms/amiga ]] && mkdir -p ${EZRomDir}/roms/amiga
mount --bind ${EZRomDir}/roms/amiga ${RomDir}/amiga
[[ ! -d ${RomDir}/amigacd32 ]] && mkdir -p ${RomDir}/amigacd32
[[ ! -d ${EZRomDir}/roms/amigacd32 ]] && mkdir -p ${EZRomDir}/roms/amigacd32
mount --bind ${EZRomDir}/roms/amigacd32 ${RomDir}/amigacd32
[[ ! -d ${RomDir}/amstradcpc ]] && mkdir -p ${RomDir}/amstradcpc
[[ ! -d ${EZRomDir}/roms/amstradcpc ]] && mkdir -p ${EZRomDir}/roms/amstradcpc
mount --bind ${EZRomDir}/roms/amstradcpc ${RomDir}/amstradcpc
[[ ! -d ${RomDir}/arcade ]] && mkdir -p ${RomDir}/arcade
[[ ! -d ${EZRomDir}/roms/arcade ]] && mkdir -p ${EZRomDir}/roms/arcade
mount --bind ${EZRomDir}/roms/arcade ${RomDir}/arcade
[[ ! -d ${RomDir}/arduboy ]] && mkdir -p ${RomDir}/arduboy
[[ ! -d ${EZRomDir}/roms/arduboy ]] && mkdir -p ${EZRomDir}/roms/arduboy
mount --bind ${EZRomDir}/roms/arduboy ${RomDir}/arduboy
[[ ! -d ${RomDir}/atari2600 ]] && mkdir -p ${RomDir}/atari2600
[[ ! -d ${EZRomDir}/roms/atari2600 ]] && mkdir -p ${EZRomDir}/roms/atari2600
mount --bind ${EZRomDir}/roms/atari2600 ${RomDir}/atari2600
[[ ! -d ${RomDir}/atari5200 ]] && mkdir -p ${RomDir}/atari5200
[[ ! -d ${EZRomDir}/roms/atari5200 ]] && mkdir -p ${EZRomDir}/roms/atari5200
mount --bind ${EZRomDir}/roms/atari5200 ${RomDir}/atari5200
[[ ! -d ${RomDir}/atari7800 ]] && mkdir -p ${RomDir}/atari7800
[[ ! -d ${EZRomDir}/roms/atari7800 ]] && mkdir -p ${EZRomDir}/roms/atari7800
mount --bind ${EZRomDir}/roms/atari7800 ${RomDir}/atari7800
[[ ! -d ${RomDir}/atari800 ]] && mkdir -p ${RomDir}/atari800
[[ ! -d ${EZRomDir}/roms/atari800 ]] && mkdir -p ${EZRomDir}/roms/atari800
mount --bind ${EZRomDir}/roms/atari800 ${RomDir}/atari800
[[ ! -d ${RomDir}/atarijaguar ]] && mkdir -p ${RomDir}/atarijaguar
[[ ! -d ${EZRomDir}/roms/atarijaguar ]] && mkdir -p ${EZRomDir}/roms/atarijaguar
mount --bind ${EZRomDir}/roms/atarijaguar ${RomDir}/atarijaguar
[[ ! -d ${RomDir}/atarilynx ]] && mkdir -p ${RomDir}/atarilynx
[[ ! -d ${EZRomDir}/roms/atarilynx ]] && mkdir -p ${EZRomDir}/roms/atarilynx
mount --bind ${EZRomDir}/roms/atarilynx ${RomDir}/atarilynx
[[ ! -d ${RomDir}/atarist ]] && mkdir -p ${RomDir}/atarist
[[ ! -d ${EZRomDir}/roms/atarist ]] && mkdir -p ${EZRomDir}/roms/atarist
mount --bind ${EZRomDir}/roms/atarist ${RomDir}/atarist
[[ ! -d ${RomDir}/atomiswave ]] && mkdir -p ${RomDir}/atomiswave
[[ ! -d ${EZRomDir}/roms/atomiswave ]] && mkdir -p ${EZRomDir}/roms/atomiswave
mount --bind ${EZRomDir}/roms/atomiswave ${RomDir}/atomiswave
[[ ! -d ${RomDir}/c128 ]] && mkdir -p ${RomDir}/c128
[[ ! -d ${EZRomDir}/roms/c128 ]] && mkdir -p ${EZRomDir}/roms/c128
mount --bind ${EZRomDir}/roms/c128 ${RomDir}/c128
[[ ! -d ${RomDir}/c16 ]] && mkdir -p ${RomDir}/c16
[[ ! -d ${EZRomDir}/roms/c16 ]] && mkdir -p ${EZRomDir}/roms/c16
mount --bind ${EZRomDir}/roms/c16 ${RomDir}/c16
[[ ! -d ${RomDir}/c64 ]] && mkdir -p ${RomDir}/c64
[[ ! -d ${EZRomDir}/roms/c64 ]] && mkdir -p ${EZRomDir}/roms/c64
mount --bind ${EZRomDir}/roms/c64 ${RomDir}/c64
[[ ! -d ${RomDir}/channelf ]] && mkdir -p ${RomDir}/channelf
[[ ! -d ${EZRomDir}/roms/channelf ]] && mkdir -p ${EZRomDir}/roms/channelf
mount --bind ${EZRomDir}/roms/channelf ${RomDir}/channelf
[[ ! -d ${RomDir}/coleco ]] && mkdir -p ${RomDir}/coleco
[[ ! -d ${EZRomDir}/roms/coleco ]] && mkdir -p ${EZRomDir}/roms/coleco
mount --bind ${EZRomDir}/roms/coleco ${RomDir}/coleco
[[ ! -d ${RomDir}/cps1 ]] && mkdir -p ${RomDir}/cps1
[[ ! -d ${EZRomDir}/roms/cps1 ]] && mkdir -p ${EZRomDir}/roms/cps1
mount --bind ${EZRomDir}/roms/cps1 ${RomDir}/cps1
[[ ! -d ${RomDir}/cps2 ]] && mkdir -p ${RomDir}/cps2
[[ ! -d ${EZRomDir}/roms/cps2 ]] && mkdir -p ${EZRomDir}/roms/cps2
mount --bind ${EZRomDir}/roms/cps2 ${RomDir}/cps2
[[ ! -d ${RomDir}/cps3 ]] && mkdir -p ${RomDir}/cps3
[[ ! -d ${EZRomDir}/roms/cps3 ]] && mkdir -p ${EZRomDir}/roms/cps3
mount --bind ${EZRomDir}/roms/cps3 ${RomDir}/cps3
[[ ! -d ${RomDir}/daphne ]] && mkdir -p ${RomDir}/daphne
[[ ! -d ${EZRomDir}/roms/daphne ]] && mkdir -p ${EZRomDir}/roms/daphne
mount --bind ${EZRomDir}/roms/daphne ${RomDir}/daphne
[[ ! -d ${RomDir}/doom ]] && mkdir -p ${RomDir}/doom
[[ ! -d ${EZRomDir}/roms/doom ]] && mkdir -p ${EZRomDir}/roms/doom
mount --bind ${EZRomDir}/roms/doom ${RomDir}/doom
[[ ! -d ${RomDir}/dreamcast ]] && mkdir -p ${RomDir}/dreamcast
[[ ! -d ${EZRomDir}/roms/dreamcast ]] && mkdir -p ${EZRomDir}/roms/dreamcast
mount --bind ${EZRomDir}/roms/dreamcast ${RomDir}/dreamcast
[[ ! -d ${RomDir}/easyrpg ]] && mkdir -p ${RomDir}/easyrpg
[[ ! -d ${EZRomDir}/roms/easyrpg ]] && mkdir -p ${EZRomDir}/roms/easyrpg
mount --bind ${EZRomDir}/roms/easyrpg ${RomDir}/easyrpg
[[ ! -d ${RomDir}/famicom ]] && mkdir -p ${RomDir}/famicom
[[ ! -d ${EZRomDir}/roms/famicom ]] && mkdir -p ${EZRomDir}/roms/famicom
mount --bind ${EZRomDir}/roms/famicom ${RomDir}/famicom
[[ ! -d ${RomDir}/fds ]] && mkdir -p ${RomDir}/fds
[[ ! -d ${EZRomDir}/roms/fds ]] && mkdir -p ${EZRomDir}/roms/fds
mount --bind ${EZRomDir}/roms/fds ${RomDir}/fds
[[ ! -d ${RomDir}/gameandwatch ]] && mkdir -p ${RomDir}/gameandwatch
[[ ! -d ${EZRomDir}/roms/gameandwatch ]] && mkdir -p ${EZRomDir}/roms/gameandwatch
mount --bind ${EZRomDir}/roms/gameandwatch ${RomDir}/gameandwatch
[[ ! -d ${RomDir}/gamegear ]] && mkdir -p ${RomDir}/gamegear
[[ ! -d ${EZRomDir}/roms/gamegear ]] && mkdir -p ${EZRomDir}/roms/gamegear
mount --bind ${EZRomDir}/roms/gamegear ${RomDir}/gamegear
[[ ! -d ${RomDir}/gb ]] && mkdir -p ${RomDir}/gb
[[ ! -d ${EZRomDir}/roms/gb ]] && mkdir -p ${EZRomDir}/roms/gb
mount --bind ${EZRomDir}/roms/gb ${RomDir}/gb
[[ ! -d ${RomDir}/gba ]] && mkdir -p ${RomDir}/gba
[[ ! -d ${EZRomDir}/roms/gba ]] && mkdir -p ${EZRomDir}/roms/gba
mount --bind ${EZRomDir}/roms/gba ${RomDir}/gba
[[ ! -d ${RomDir}/gbc ]] && mkdir -p ${RomDir}/gbc
[[ ! -d ${EZRomDir}/roms/gbc ]] && mkdir -p ${EZRomDir}/roms/gbc
mount --bind ${EZRomDir}/roms/gbc ${RomDir}/gbc
[[ ! -d ${RomDir}/genesis ]] && mkdir -p ${RomDir}/genesis
[[ ! -d ${EZRomDir}/roms/genesis ]] && mkdir -p ${EZRomDir}/roms/genesis
mount --bind ${EZRomDir}/roms/genesis ${RomDir}/genesis
[[ ! -d ${RomDir}/intellivision ]] && mkdir -p ${RomDir}/intellivision
[[ ! -d ${EZRomDir}/roms/intellivision ]] && mkdir -p ${EZRomDir}/roms/intellivision
mount --bind ${EZRomDir}/roms/intellivision ${RomDir}/intellivision
[[ ! -d ${RomDir}/j2me ]] && mkdir -p ${RomDir}/j2me
[[ ! -d ${EZRomDir}/roms/j2me ]] && mkdir -p ${EZRomDir}/roms/j2me
mount --bind ${EZRomDir}/roms/j2me ${RomDir}/j2me
[[ ! -d ${RomDir}/mame ]] && mkdir -p ${RomDir}/mame
[[ ! -d ${EZRomDir}/roms/mame ]] && mkdir -p ${EZRomDir}/roms/mame
mount --bind ${EZRomDir}/roms/mame ${RomDir}/mame
[[ ! -d ${RomDir}/mastersystem ]] && mkdir -p ${RomDir}/mastersystem
[[ ! -d ${EZRomDir}/roms/mastersystem ]] && mkdir -p ${EZRomDir}/roms/mastersystem
mount --bind ${EZRomDir}/roms/mastersystem ${RomDir}/mastersystem
[[ ! -d ${RomDir}/megadrive ]] && mkdir -p ${RomDir}/megadrive
[[ ! -d ${EZRomDir}/roms/megadrive ]] && mkdir -p ${EZRomDir}/roms/megadrive
mount --bind ${EZRomDir}/roms/megadrive ${RomDir}/megadrive
[[ ! -d ${RomDir}/megaduck ]] && mkdir -p ${RomDir}/megaduck
[[ ! -d ${EZRomDir}/roms/megaduck ]] && mkdir -p ${EZRomDir}/roms/megaduck
mount --bind ${EZRomDir}/roms/megaduck ${RomDir}/megaduck
[[ ! -d ${RomDir}/msx ]] && mkdir -p ${RomDir}/msx
[[ ! -d ${EZRomDir}/roms/msx ]] && mkdir -p ${EZRomDir}/roms/msx
mount --bind ${EZRomDir}/roms/msx ${RomDir}/msx
[[ ! -d ${RomDir}/msx2 ]] && mkdir -p ${RomDir}/msx2
[[ ! -d ${EZRomDir}/roms/msx2 ]] && mkdir -p ${EZRomDir}/roms/msx2
mount --bind ${EZRomDir}/roms/msx2 ${RomDir}/msx2
[[ ! -d ${RomDir}/n64 ]] && mkdir -p ${RomDir}/n64
[[ ! -d ${EZRomDir}/roms/n64 ]] && mkdir -p ${EZRomDir}/roms/n64
mount --bind ${EZRomDir}/roms/n64 ${RomDir}/n64
[[ ! -d ${RomDir}/naomi ]] && mkdir -p ${RomDir}/naomi
[[ ! -d ${EZRomDir}/roms/naomi ]] && mkdir -p ${EZRomDir}/roms/naomi
mount --bind ${EZRomDir}/roms/naomi ${RomDir}/naomi
[[ ! -d ${RomDir}/nds ]] && mkdir -p ${RomDir}/nds
[[ ! -d ${EZRomDir}/roms/nds ]] && mkdir -p ${EZRomDir}/roms/nds
mount --bind ${EZRomDir}/roms/nds ${RomDir}/nds
[[ ! -d ${RomDir}/neogeo ]] && mkdir -p ${RomDir}/neogeo
[[ ! -d ${EZRomDir}/roms/neogeo ]] && mkdir -p ${EZRomDir}/roms/neogeo
mount --bind ${EZRomDir}/roms/neogeo ${RomDir}/neogeo
[[ ! -d ${RomDir}/nes ]] && mkdir -p ${RomDir}/nes
[[ ! -d ${EZRomDir}/roms/nes ]] && mkdir -p ${EZRomDir}/roms/nes
mount --bind ${EZRomDir}/roms/nes ${RomDir}/nes
[[ ! -d ${RomDir}/ngp ]] && mkdir -p ${RomDir}/ngp
[[ ! -d ${EZRomDir}/roms/ngp ]] && mkdir -p ${EZRomDir}/roms/ngp
mount --bind ${EZRomDir}/roms/ngp ${RomDir}/ngp
[[ ! -d ${RomDir}/ngpc ]] && mkdir -p ${RomDir}/ngpc
[[ ! -d ${EZRomDir}/roms/ngpc ]] && mkdir -p ${EZRomDir}/roms/ngpc
mount --bind ${EZRomDir}/roms/ngpc ${RomDir}/ngpc
[[ ! -d ${RomDir}/openbor ]] && mkdir -p ${RomDir}/openbor
[[ ! -d ${EZRomDir}/roms/openbor ]] && mkdir -p ${EZRomDir}/roms/openbor
mount --bind ${EZRomDir}/roms/openbor ${RomDir}/openbor
[[ ! -d ${RomDir}/palm ]] && mkdir -p ${RomDir}/palm
[[ ! -d ${EZRomDir}/roms/palm ]] && mkdir -p ${EZRomDir}/roms/palm
mount --bind ${EZRomDir}/roms/palm ${RomDir}/palm
[[ ! -d ${RomDir}/pc98 ]] && mkdir -p ${RomDir}/pc98
[[ ! -d ${EZRomDir}/roms/pc98 ]] && mkdir -p ${EZRomDir}/roms/pc98
mount --bind ${EZRomDir}/roms/pc98 ${RomDir}/pc98
[[ ! -d ${RomDir}/pcengine ]] && mkdir -p ${RomDir}/pcengine
[[ ! -d ${EZRomDir}/roms/pcengine ]] && mkdir -p ${EZRomDir}/roms/pcengine
mount --bind ${EZRomDir}/roms/pcengine ${RomDir}/pcengine
[[ ! -d ${RomDir}/pcenginecd ]] && mkdir -p ${RomDir}/pcenginecd
[[ ! -d ${EZRomDir}/roms/pcenginecd ]] && mkdir -p ${EZRomDir}/roms/pcenginecd
mount --bind ${EZRomDir}/roms/pcenginecd ${RomDir}/pcenginecd
[[ ! -d ${RomDir}/pcfx ]] && mkdir -p ${RomDir}/pcfx
[[ ! -d ${EZRomDir}/roms/pcfx ]] && mkdir -p ${EZRomDir}/roms/pcfx
mount --bind ${EZRomDir}/roms/pcfx ${RomDir}/pcfx
[[ ! -d ${RomDir}/pico-8 ]] && mkdir -p ${RomDir}/pico-8
[[ ! -d ${EZRomDir}/roms/pico-8 ]] && mkdir -p ${EZRomDir}/roms/pico-8
mount --bind ${EZRomDir}/roms/pico-8 ${RomDir}/pico-8
[[ ! -d ${RomDir}/ports ]] && mkdir -p ${RomDir}/ports
[[ ! -d ${EZRomDir}/roms/ports ]] && mkdir -p ${EZRomDir}/roms/ports
mount --bind ${EZRomDir}/roms/ports ${RomDir}/ports
[[ ! -d ${RomDir}/psp ]] && mkdir -p ${RomDir}/psp
[[ ! -d ${EZRomDir}/roms/psp ]] && mkdir -p ${EZRomDir}/roms/psp
mount --bind ${EZRomDir}/roms/psp ${RomDir}/psp
[[ ! -d ${RomDir}/pspminis ]] && mkdir -p ${RomDir}/pspminis
[[ ! -d ${EZRomDir}/roms/pspminis ]] && mkdir -p ${EZRomDir}/roms/pspminis
mount --bind ${EZRomDir}/roms/pspminis ${RomDir}/pspminis
[[ ! -d ${RomDir}/psx ]] && mkdir -p ${RomDir}/psx
[[ ! -d ${EZRomDir}/roms/psx ]] && mkdir -p ${EZRomDir}/roms/psx
mount --bind ${EZRomDir}/roms/psx ${RomDir}/psx
[[ ! -d ${RomDir}/satellaview ]] && mkdir -p ${RomDir}/satellaview
[[ ! -d ${EZRomDir}/roms/satellaview ]] && mkdir -p ${EZRomDir}/roms/satellaview
mount --bind ${EZRomDir}/roms/satellaview ${RomDir}/satellaview
[[ ! -d ${RomDir}/saturn ]] && mkdir -p ${RomDir}/saturn
[[ ! -d ${EZRomDir}/roms/saturn ]] && mkdir -p ${EZRomDir}/roms/saturn
mount --bind ${EZRomDir}/roms/saturn ${RomDir}/saturn
[[ ! -d ${RomDir}/scv ]] && mkdir -p ${RomDir}/scv
[[ ! -d ${EZRomDir}/roms/scv ]] && mkdir -p ${EZRomDir}/roms/scv
mount --bind ${EZRomDir}/roms/scv ${RomDir}/scv
[[ ! -d ${RomDir}/sega32x ]] && mkdir -p ${RomDir}/sega32x
[[ ! -d ${EZRomDir}/roms/sega32x ]] && mkdir -p ${EZRomDir}/roms/sega32x
mount --bind ${EZRomDir}/roms/sega32x ${RomDir}/sega32x
[[ ! -d ${RomDir}/segacd ]] && mkdir -p ${RomDir}/segacd
[[ ! -d ${EZRomDir}/roms/segacd ]] && mkdir -p ${EZRomDir}/roms/segacd
mount --bind ${EZRomDir}/roms/segacd ${RomDir}/segacd
[[ ! -d ${RomDir}/sfc ]] && mkdir -p ${RomDir}/sfc
[[ ! -d ${EZRomDir}/roms/sfc ]] && mkdir -p ${EZRomDir}/roms/sfc
mount --bind ${EZRomDir}/roms/sfc ${RomDir}/sfc
[[ ! -d ${RomDir}/sg-1000 ]] && mkdir -p ${RomDir}/sg-1000
[[ ! -d ${EZRomDir}/roms/sg-1000 ]] && mkdir -p ${EZRomDir}/roms/sg-1000
mount --bind ${EZRomDir}/roms/sg-1000 ${RomDir}/sg-1000
[[ ! -d ${RomDir}/snes ]] && mkdir -p ${RomDir}/snes
[[ ! -d ${EZRomDir}/roms/snes ]] && mkdir -p ${EZRomDir}/roms/snes
mount --bind ${EZRomDir}/roms/snes ${RomDir}/snes
[[ ! -d ${RomDir}/snesmsu1 ]] && mkdir -p ${RomDir}/snesmsu1
[[ ! -d ${EZRomDir}/roms/snesmsu1 ]] && mkdir -p ${EZRomDir}/roms/snesmsu1
mount --bind ${EZRomDir}/roms/snesmsu1 ${RomDir}/snesmsu1
[[ ! -d ${RomDir}/sufami ]] && mkdir -p ${RomDir}/sufami
[[ ! -d ${EZRomDir}/roms/sufami ]] && mkdir -p ${EZRomDir}/roms/sufami
mount --bind ${EZRomDir}/roms/sufami ${RomDir}/sufami
[[ ! -d ${RomDir}/supervision ]] && mkdir -p ${RomDir}/supervision
[[ ! -d ${EZRomDir}/roms/supervision ]] && mkdir -p ${EZRomDir}/roms/supervision
mount --bind ${EZRomDir}/roms/supervision ${RomDir}/supervision
[[ ! -d ${RomDir}/uzebox ]] && mkdir -p ${RomDir}/uzebox
[[ ! -d ${EZRomDir}/roms/uzebox ]] && mkdir -p ${EZRomDir}/roms/uzebox
mount --bind ${EZRomDir}/roms/uzebox ${RomDir}/uzebox
[[ ! -d ${RomDir}/vectrex ]] && mkdir -p ${RomDir}/vectrex
[[ ! -d ${EZRomDir}/roms/vectrex ]] && mkdir -p ${EZRomDir}/roms/vectrex
mount --bind ${EZRomDir}/roms/vectrex ${RomDir}/vectrex
[[ ! -d ${RomDir}/vic20 ]] && mkdir -p ${RomDir}/vic20
[[ ! -d ${EZRomDir}/roms/vic20 ]] && mkdir -p ${EZRomDir}/roms/vic20
mount --bind ${EZRomDir}/roms/vic20 ${RomDir}/vic20
[[ ! -d ${RomDir}/vircon32 ]] && mkdir -p ${RomDir}/vircon32
[[ ! -d ${EZRomDir}/roms/vircon32 ]] && mkdir -p ${EZRomDir}/roms/vircon32
mount --bind ${EZRomDir}/roms/vircon32 ${RomDir}/vircon32
[[ ! -d ${RomDir}/virtualboy ]] && mkdir -p ${RomDir}/virtualboy
[[ ! -d ${EZRomDir}/roms/virtualboy ]] && mkdir -p ${EZRomDir}/roms/virtualboy
mount --bind ${EZRomDir}/roms/virtualboy ${RomDir}/virtualboy
[[ ! -d ${RomDir}/wasm4 ]] && mkdir -p ${RomDir}/wasm4
[[ ! -d ${EZRomDir}/roms/wasm4 ]] && mkdir -p ${EZRomDir}/roms/wasm4
mount --bind ${EZRomDir}/roms/wasm4 ${RomDir}/wasm4
[[ ! -d ${RomDir}/wonderswan ]] && mkdir -p ${RomDir}/wonderswan
[[ ! -d ${EZRomDir}/roms/wonderswan ]] && mkdir -p ${EZRomDir}/roms/wonderswan
mount --bind ${EZRomDir}/roms/wonderswan ${RomDir}/wonderswan
[[ ! -d ${RomDir}/wonderswancolor ]] && mkdir -p ${RomDir}/wonderswancolor
[[ ! -d ${EZRomDir}/roms/wonderswancolor ]] && mkdir -p ${EZRomDir}/roms/wonderswancolor
mount --bind ${EZRomDir}/roms/wonderswancolor ${RomDir}/wonderswancolor
[[ ! -d ${RomDir}/x1 ]] && mkdir -p ${RomDir}/x1
[[ ! -d ${EZRomDir}/roms/x1 ]] && mkdir -p ${EZRomDir}/roms/x1
mount --bind ${EZRomDir}/roms/x1 ${RomDir}/x1
[[ ! -d ${RomDir}/x68000 ]] && mkdir -p ${RomDir}/x68000
[[ ! -d ${EZRomDir}/roms/x68000 ]] && mkdir -p ${EZRomDir}/roms/x68000
mount --bind ${EZRomDir}/roms/x68000 ${RomDir}/x68000
[[ ! -d ${RomDir}/zx81 ]] && mkdir -p ${RomDir}/zx81
[[ ! -d ${EZRomDir}/roms/zx81 ]] && mkdir -p ${EZRomDir}/roms/zx81
mount --bind ${EZRomDir}/roms/zx81 ${RomDir}/zx81
[[ ! -d ${RomDir}/zxspectrum ]] && mkdir -p ${RomDir}/zxspectrum
[[ ! -d ${EZRomDir}/roms/zxspectrum ]] && mkdir -p ${EZRomDir}/roms/zxspectrum
mount --bind ${EZRomDir}/roms/zxspectrum ${RomDir}/zxspectrum
