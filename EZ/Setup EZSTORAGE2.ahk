#Requires AutoHotkey v2.0

loop {
    SD2UserSel := DirSelect("::{20D04FE0-3AEA-1069-A2D8-08002B30309D}",0,"Select SD2 card to prepare`nSubdirs are ignored.")
    if (SD2UserSel := "" )
        ExitApp

    SplitPath(SD2UserSel,,,,, &SD2)

    if NOT (DriveGetType(SD2) = "REMOVABLE") {
        msgbox "Not removable, refusing to prep"
        ExitApp
    }
    if NOT (DriveGetFileSystem = "FAT32") {
        msgbox "Not Fat32, refusing to prep"
        ExitApp
    }
    Really := MsgBox("Really prep " SD2 "?`n`nThis will modify your card's contents", "Really?","YNC")
    if (Really = "Yes")
        break
    if (Really = "No")
        continue
    if (Really = "Cancel")
        ExitApp
}




; SerialMap := Map()
; loop parse DriveGetList("REMOVABLE") { ;, DelimitChar, OmitChar
;     MsgBox A_LoopField
;     Serial:=DriveGetSerial(A_LoopField ":")
;     SerialMap.Has(Serial) ? SerialMap[Serial].Push(A_LoopField) : SerialMap[Serial] := [A_LoopField]
; }
; msg := ""
; for Serial, DriveArray in SerialMap {
;     msg := "Serial: " Serial "`n"
;     msg .= "Mounts: "
;     loop DriveArray.Length 
;         msg .= DriveArray[A_Index] ((DriveArray.Length > 1) ? ", " : "")
; }
; MsgBox msg
