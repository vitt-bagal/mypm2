#!/bin/bash
declare -a Arch=("amd64" "s390x")
for arch in "${Arch[@]}"
do
        echo "Buiding image for $arch"
        docker build --build-arg ARCH=$arch -t bagalvitthal/mypm2-linux-$arch:latest .
        docker push bagalvitthal/mypm2-linux-$arch:latest
done

DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create -a bagalvitthal/mypm2:latest \
                                                        bagalvitthal/mypm2-linux-amd64:latest \
                                                        bagalvitthal/mypm2-linux-s390x:latest
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push bagalvitthal/mypm2:latest
