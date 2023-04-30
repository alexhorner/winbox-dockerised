# WinBox Dockerised
A simple container which runs Mikrotik's WinBox64 via OpenBox and x11vnc, served via VNC on port 5900

The purpose of this container is to provide a simple WinBox instance ~~which is fully compatible with GNS3 (it can be imported in and used with GNS3's VNC mode)~~ GNS3 support is intended but not there yet.

## Environment Variables
```
VNC_WIDTH - The width of the VNC session in pixels, defaults to 1280
VNC_HEIGHT - The height of the VNC session in pixels, defaults to 720
VNC_PIXELDEPTH - The framebuffer pixeldepth of the VNC session, defaults to 24
```

## Example
Here's a quick example command you can run to host an instance of this container on port 5900 of the host machine. This will use host networking mode so that any Mikrotik devices on the same network as your docker host machine are discovered automatically
```bash
docker run -it --rm --network host alexhorner/winbox-dockerised
```

