## What is this?
Multiarch docker build for FusionPBX + Freeswitch(tested with x86_64 and armv7).

## Build
Run `build-freeswitch.sh` first to build the Freeswitch base image(takes the longest). This builds `arm/v7` and `amd64` by default but you can pass as parameter another arch that you need(e.g. `arm64`).  
You then build the Dockerfile in the current file.

## Run
You can just `docker-compose up -d` which will pull images from docker hub if they are not built locally.

## Mini How-To Multiarch builds
There are no all-in one tutorials but you can read about multiarch builds [https://docs.docker.com/buildx/working-with-buildx/](here).  
You will also need to enable binfmt and have qemu on your system which is the harder part.  
  
If you are on docker 19.03 or later you can use the built in `buildx` or install the latest version from [https://github.com/docker/buildx/](https://github.com/docker/buildx/).  
  
A good tutorial on enabling binfmt and setting things up: [https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/getting-started-with-docker-for-arm-on-linux](https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/getting-started-with-docker-for-arm-on-linux).  
  
For QEMU use your distro's package or, if you are feeling adventurous(like I did), build it from source and use `checkinstall` so that it doesn't blow up your system: [https://www.qemu.org/download/](https://www.qemu.org/download/).  
I used qemu 5.0.0 for this build.

