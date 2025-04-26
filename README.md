# WinBox Dockerised
A simple container which runs Mikrotik's WinBox via OpenBox and x11vnc, served via VNC on port 5900

The purpose of this container is to provide a simple WinBox instance which can be run standalone, but is also fully compatible with GNS3 (it can be imported in and used with GNS3's VNC mode)

## Environment Variables
```
VNC_BUILTIN_WIDTH - The width of the built-in VNC session in pixels, defaults to 1280
VNC_BUILTIN_HEIGHT - The height of the built-in VNC session in pixels, defaults to 720
VNC_BUILTIN_PIXELDEPTH - The framebuffer pixeldepth of the built-in VNC session, defaults to 24
VNC_BUILTIN_DISABLED - Disables the built-in VNC server. You must pass through an X server and display environment variable to use the container, defaults to false
```

## Example
Here's a quick example command you can run to host an instance of this container on port 5900 of the host machine. This will use host networking mode so that any Mikrotik devices on the same network as your docker host machine are discovered automatically
```bash
docker run -it --rm --network host alexhorner/winbox-dockerised
```

Should you encounter `Failed to close file descriptor for child process (Operation not permitted)` you may need to add `--security-opt seccomp=unconfined`, however this can have security implications, see https://gist.github.com/nathabonfim59/b088db8752673e1e7acace8806390242
```bash
docker run -it --rm --network host --security-opt seccomp=unconfined alexhorner/winbox-dockerised
```

## DHCP
DHCP is not enabled by default in the container, however the container is Debian based so you can install any tools you may need. The `dhclient` command is included by default to obtain a DHCP address manually, as well as the `ip` command for viewing IPs and setting static ones.

You can access a terminal by right-clicking in a blank black space of the VNC desktop, which will open the OpenBox navigation menu where you can open xterm.

## Use with GNS3
- Under Preferences, go to Docker Containers, click New, select New image and enter `docker.io/alexhorner/winbox-dockerised:latest` then click Next.
- Enter a new name, such as `WinBox Dockerised` and click Next.
- Choose as many network adapters as you may need. Recommended value is 1, then click Next.
- Leave Start command empty and click Next.
- Set Console type to VNC and click Next.
- In the Environment text box, enter `VNC_BUILTIN_DISABLED=true` and click Finish.
- Click Ok in the template list.
- Drag a new instance into your project from the All Devices menu.

You will now be able to start the instance, and double click it for a VNC viewer, where after a moment or two WinBox will load up and start communicating on the network adapter(s) to find devices
