#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

# Source predefined functions and variables
. /etc/profile

PORT="prince"
# init_port binary audio(alsa. pulseaudio, default)
init_port ${PORT} alsa

clear >/dev/console

jslisten set "/usr/bin/killall ${PORT}"

[[ ! -f "/storage/.config/distribution/configs/SDLPoP/SDLPoP.cfg" ]] && touch "/storage/.config/distribution/configs/SDLPoP/SDLPoP.cfg"

# SDLPop will complain about a missing data and config files by showing a nice blank screen after the intro

cd /storage/.config/distribution/configs/SDLPoP

${PORT} &>>/tmp/logs/exec.log

jslisten stop

ret_error=$?

end_port

exit $ret_error