# [EatPrilosec/R36S-Multiboot is my testing repo](https://github.com/EatPrilosec/R36S-Multiboot)

# [Releases are at r36s-stuff.github.io/R36S-Multiboot](https://r36s-stuff.github.io/R36S-Multiboot)

# Gameconsole R36S Multiboot images (and builder)

## \#\#\# WIP \#\#\#

### Notes
- Nothing is fully ready yet, expect problems
- Armbian standalone images are at [R36S-Stuff](https://github.com/R36S-Stuff/R36S-Armbian/releases/latest)
- Image(s) are big and most likely split into parts for github release.
    - [get all the numbered files (.001, etc)](https://r36s-stuff.github.io/R36S-Multiboot) and extract it with 7zip or nanaZip. (linux users, ive found p7zip to be unreliabe, try the official 7zip if you have issues.)

### Builder info
- builds in WSL
- might need dependencies to be installed (i will do this automatically later)
- syntax: `./buildimg ark rocknix armbian <name-of-os-folder-NO-SPACES>`
- can build single boot images for testing (or just u-boot with no OS arguments)

## Multiboot Buttons
```

#    Down       =   Rocknix
#    Left       =   PAN4ELEC
#    Up         =   UnofficialOS
#    Right      =   Amberelec

#    Function   =   <Empty>
#    Start (+)  =   ArkOS
#    Select (-) =   <Empty>

#    B (south)  =   Armbian Bookworm
#    Y (west)   =   Armbian Jammy
#    X (north)  =   Armbian Noble
#    A (east)   =   Armbian Plucky (TODO: armbian to one button after testing)


# # # # # # # # # # # # # # # # # # # #
#  _________________________________  #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |_________________________________| #
#                                     #
#         1              Noble        #
#         ▲               (X)         #
#     4 ◄   ► 2    Jammy(Y) (A)Plucky #
#         ▼               (B)         #
#         3      (Fn)    Bookworm     #
#         _                _          #
#       /   \  (-)  (+)  /   \        #
#      |     | Roc  Ark |     |       #
#       \ _ /            \ _ /        #
#                                     #
# # # # # # # # # # # # # # # # # # # #
```


# black screen?
# Panel Chooser info

These images support the original R36S panel, and the 4 new panels, all in one image!

- Hold R1 and a face button (see below) while powering on the device to set panel
- if done correctly, the device will power off, and the next boot should show the logo.
    - if you miss the window and the R36S doesnt automatically power off, let it sit for a bit to setup the EZSTORAGE partition.
        - this can take 5-15 minutes depending on the first boot OS and sedcard speed.
- if you dont know what panel you have, just try booting holding the same buttons again, if you see a logo, next boot is safe to start using the image.
- you can make the setting permanet (and prevent accidental panel changing) **by holding R1 and Volume Down** during any boot.


## Hold R1 to set panel, Set panel via the following buttons
```
    # Up        =   New Panel 1
    # Right     =   New Panel 2
    # Down      =   New Panel 3
    # Left      =   New Panel 4
    # A (east)  =   Original Panel


# # # # # # # # # # # # # # # # # # # #
#  _________________________________  #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |                                 | #
# |_________________________________| #
#                                     #
#         1                           #
#         ▲               (X)         #
#     4 ◄   ► 2         (Y) (A)Orig   #
#         ▼               (B)         #
#         3                           #
#         _                _          #
#       /   \            /   \        #
#      |     |          |     |       #
#       \ _ /            \ _ /        #
#                                     #
# # # # # # # # # # # # # # # # # # # #
```

