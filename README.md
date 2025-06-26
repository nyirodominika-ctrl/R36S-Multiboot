# Gameconsole R36S Multiboot images (and builder)

## \#\#\# WIP \#\#\#

### Multiboot Images info
- nothing is ready yet, expect problems
- Armbian is the least ready, uses ArkOS's kernel, and requires a usb keyboard or UART to setup at the moment.
- image(s) are big and most likely split into parts for github release. get all the numbered files (.001, etc) and extract it with 7zip or nanaZip 

### Builder info
- builds in WSL
- might need dependencies to be installed (i will do this automatically later)
- `./buildimg ark rocknix armbian <name-of-os-folder-NO-SPACES>`
- can build single boot images for testing (or just u-boot with no OS arguments)

```
#     gpio ref
# Func      =   c4
# Start     =   d12
# Select    =   d9

# X (north) =   b7
# Y (west)  =   b6
# A (east)  =   b2
# B (south) =   b5

# Up        =   b12
# Down      =   b13
# Left      =   b14
# Right     =   b15

 
#    Down       =   
#    Left       =   
#    Up         =   
#    Right      =   

#    Function   =   
#    Start (+)  =   ArkOS
#    Select (-) =   Rocknix

#    B (south)  =   Armbian Bookworm
#    Y (west)   =   Armbian Jammy
#    X (north)  =   Armbian Noble
#    A (east)   =   Armbian Plucky


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
