#!/usr/bin/env zsh
set -eo pipefail

IMG_FILE="steamdeck-recovery-4.img"

BASE_DIR="${0:A:h}"
MOUNT_DIR="/run/user/$UID/steamdeck"

IMG="$BASE_DIR/$IMG_FILE"

integer start sectors
print -u2 - "reading partitions from $IMG_FILE"
fdisk -l $IMG | grep -F "Linux root" | read part start s_end sectors ignore

print -u2 - "\nmounting recovery image"
sudo mount --mkdir -wvo offset=$[512*start],sizelimit=$[512*sectors] $IMG $MOUNT_DIR
{
	sudo btrfs property set -ts $MOUNT_DIR ro false
	pushd "$MOUNT_DIR/etc"

	print -u2 - "\nenabling passwordless sudo for deck user"
	print - "deck ALL=(ALL) NOPASSWD:ALL" | sudo tee "sudoers.d/deck"
	sudo chmod -v 0440 "sudoers.d/deck"
	sudo rm -vf "sudoers.d/wheel"

	print -u2 - "\nsetting plasma desktop as the the default session"
	cat <<-EOF | sudo tee "sddm.conf.d/zz-steamos-autologin.conf"
	[Autologin]
	Session=plasma.desktop
	EOF

	popd
} always {
	cd $BASE_DIR # leave the mount dir
	sudo umount -vR $MOUNT_DIR
	print -u2 - "\ndone."
}
