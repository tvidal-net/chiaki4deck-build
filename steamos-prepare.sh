#!/usr/bin/env bash
set -eo pipefail

if [ 0 -ne $UID ]
then
	>&2 echo "must be run as root, try running: "
	>&2 echo "pkexec $0 $*"
	exit 1
fi

cat > /etc/sudoers.d/nopasswd <<EOF
deck ALL=(ALL:ALL) NOPASSWD: ALL
EOF

# populate pacman keys
pacman-key --populate

# remove signature requirement for pacman (CAUTION: DANGEROUS)
sed -i.old -e 's/SigLevel.*/SigLevel    =  Never/i' /etc/pacman.conf

function _pac-install () {
	pacman -S --noconfirm --overwrite \* $*
}

_pac-install archlinux-keyring

_pac-install base-devel glibc linux-api-headers systemd mesa hidapi libevdev \
	libglvnd qt5-base qt5-multimedia qt5-svg sdl2 opus ffmpeg openssl gcc-libs fftw \
	libva-mesa-driver git cmake python-setuptools python-protobuf libva
