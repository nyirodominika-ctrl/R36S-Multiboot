#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

# Source predefined functions and variables
. /etc/profile

PORT="opentyrian"
# init_port binary audio(alsa. pulseaudio, default)
init_port ${PORT} alsa

clear >/dev/console

jslisten set "/usr/bin/killall ${PORT}"

${PORT} -t /storage/roms/homebrew/opentyrian &>>/tmp/logs/exec.log

jslisten stop

ret_error=$?

[[ "$ret_error" != 0 ]] && ee_check_bios "OpenTyrian"

end_port

exit $ret_error