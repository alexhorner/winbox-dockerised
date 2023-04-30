#!/bin/bash

#Prepare variables
export DISPLAY=":0"
: "${VNC_WIDTH:=1280}"
: "${VNC_HEIGHT:=720}"
: "${VNC_PIXELDEPTH:=24}"

#Ensure WinBox is downloaded
if [ -f "/winbox64.exe" ]; then
   echo "WinBox64 has already been downloaded"
else
   echo "WinBox64 is missing, downloading..."
   wget -O /winbox64.exe https://download.mikrotik.com/winbox/3.37/winbox64.exe
fi

#Launch the virtual framebuffer and wait for it to become ready
echo "Using display ${DISPLAY} with size of ${VNC_WIDTH}x${VNC_HEIGHT} with pixel depth ${VNC_PIXELDEPTH}"
Xvfb ${DISPLAY} -screen 0 "${VNC_WIDTH}x${VNC_HEIGHT}x${VNC_PIXELDEPTH}" &

while true
do
    if xdpyinfo -display "${DISPLAY}" > /dev/null 2>/dev/null; then
        echo "Display ${DISPLAY} is ready!"
        break
    else
        echo "Waiting for display ${DISPLAY} to become ready..."
        sleep 0.25
    fi
done

#Launch the VNC server
x11vnc -bg -forever -nopw -display ${DISPLAY} &

#Launch OpenBox
openbox &

#Launch WinBox
wine /winbox64.exe
