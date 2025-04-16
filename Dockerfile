FROM docker.io/debian:bookworm

#Install dependencies (One line, to minimize size)
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y procps wget unzip iproute2 isc-dhcp-client inetutils-ping inetutils-traceroute xterm openbox x11-utils x11vnc xvfb libegl1 libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0-dev autocutsel \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

#Download WinBox
#Permission has been granted by Mikrotik (via support@mikrotik.com, ticket number #[SUP-114983]) to distribute WinBox unmodified within this image.
RUN wget -O /tmp/winbox.zip https://download.mikrotik.com/routeros/winbox/4.0beta18/WinBox_Linux.zip && unzip /tmp/winbox.zip -d / && rm /tmp/winbox.zip

#Copy in entrypoint script and WinBox license
WORKDIR /
COPY ./entrypoint.sh ./WINBOX_LICENSE /
# Create directories and edit OpenBox config to launch maximized
RUN mkdir -p /root/.local/share/MikroTik/WinBox/workspaces/ && sed -i 's#</applications>#<application class="*"><maximized>yes</maximized></application></applications>#' /etc/xdg/openbox/rc.xml

#Finalise
EXPOSE 5900
ENTRYPOINT ["bash", "/entrypoint.sh"]
