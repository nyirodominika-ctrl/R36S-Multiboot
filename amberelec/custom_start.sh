#!/bin/bash
. /etc/profile
case "${1}" in
"before")
        /bin/bash /storage/.config/autostart/00-mount-EZSTORAGE.sh
        /bin/bash /storage/.config/autostart/01-expand-EZSTORAGE.sh
        /bin/bash /storage/.config/autostart/02-setup-EZSTORAGE.sh
        exit 0
        ;;
*)
    exit 0
        ;;
esac
exit 0
