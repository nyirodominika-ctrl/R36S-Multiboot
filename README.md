# Gameconsole R36S Multiboot images (and builder)

## ### WIP \#\#\#

### Multiboot Images info
- nothing is ready yet, expect problems
- Armbian is the least ready, uses ArkOS's kernel, and requires a usb keyboard or UART to setup at the moment.
- image(s) are big and most likely split into parts for github release. get all the numbered files (.001, etc) and extract it with 7zip or nanaZip 

### Builder info
- builds in WSL
- might need dependencies to be installed (i will do this automatically later)
- `./buildimg ark rocknix armbian <name-of-os-folder-NO-SPACES>`
- can build single boot images for testing (or just u-boot with no OS arguments)
