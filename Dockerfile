FROM docker.io/debian:bookworm

#Install Misc
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install procps wget iproute2 isc-dhcp-client inetutils-ping inetutils-traceroute xterm -y \
    && rm -rf /var/lib/apt/lists/*

#Intall Wine (https://wiki.winehq.org/Debian)
RUN dpkg --add-architecture i386
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install --install-recommends winehq-stable -y \
    && rm -rf /var/lib/apt/lists/*

#Install WM
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install openbox -y \
    && rm -rf /var/lib/apt/lists/*

#Install VNC
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install x11-utils x11vnc xvfb -y \
    && rm -rf /var/lib/apt/lists/*

#Preconfigure Wine
RUN winecfg

#Copy in entrypoint script and WinBox license
WORKDIR /
COPY ./entrypoint.sh /entrypoint.sh
COPY ./WINBOX_LICENSE /WINBOX_LICENSE

#Download WinBox
#Permission has been granted by Mikrotik (via support@mikrotik.com, ticket number #[SUP-114983]) to distribute WinBox unmodified within this image.
RUN wget -O /winbox64.exe https://download.mikrotik.com/winbox/3.40/winbox64.exe

#Finalise
EXPOSE 5900
ENTRYPOINT ["bash", "/entrypoint.sh"]
