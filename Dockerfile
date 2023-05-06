FROM docker.io/debian:bullseye

#Intall Wine
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install wine64 -y \
    && rm -rf /var/lib/apt/lists/*

#Install WM
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install openbox -y \
    && rm -rf /var/lib/apt/lists/*

#Install VNC
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install x11vnc xvfb -y \
    && rm -rf /var/lib/apt/lists/*

#Install Misc
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install wget iproute2 isc-dhcp-client inetutils-ping inetutils-traceroute -y \
    && rm -rf /var/lib/apt/lists/*

#Copy in entrypoint script
WORKDIR /
COPY ./entrypoint.sh /entrypoint.sh

#Download WinBox
#Permission has been granted by Mikrotik (via support@mikrotik.com, ticket number #[SUP-114983]) to distribute WinBox unmodified within this image.
RUN wget -O /winbox64.exe https://download.mikrotik.com/winbox/3.37/winbox64.exe

#Finalise
EXPOSE 5900
ENTRYPOINT ["bash", "/entrypoint.sh"]
