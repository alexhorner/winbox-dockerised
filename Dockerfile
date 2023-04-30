FROM docker.io/debian:bullseye

#Intall Wine
RUN apt-get update \
    && apt-get install wine64 -y \
    && rm -rf /var/lib/apt/lists/*

#Install WM
RUN apt-get update \
    && apt-get install openbox -y \
    && rm -rf /var/lib/apt/lists/*

#Install VNC
RUN apt-get update \
    && apt-get install x11vnc xvfb -y \
    && rm -rf /var/lib/apt/lists/*

#Install Misc
RUN apt-get update \
    && apt-get install wget -y \
    && rm -rf /var/lib/apt/lists/*

#Copy in entrypoint script
WORKDIR /
COPY ./entrypoint.sh /entrypoint.sh

#Finalise
EXPOSE 5900
ENTRYPOINT ["bash", "/entrypoint.sh"]
