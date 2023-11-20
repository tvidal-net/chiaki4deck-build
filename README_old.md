# Build chiaki4deck on the SteamDeck

So, I was having several problems trying to run chiaki and since I am an archlinux user for years and use chiaki
without any problems on my linux workstation, I thought I should try to build it from scratch and see if the
problems would go away and this has actually fixed it!

You can use a **qemu** [vm of steam-os](https://blogs.igalia.com/berto/2022/07/05/running-the-steam-decks-os-in-a-virtual-machine-using-qemu/)
but it also works directly on the steam deck desktop mode using a mouse/keyboard or a barrier client.

If you have any problems, please message me and I will try to help...

You may find it easier to open this page on steamdeck's firefox to copy/paste the commands below.

## Make the partition writable
```bash
# set a password for the deck user
passwd
# disable the readonly constraint
sudo steamos-readonly disable
```

## Install build dependencies
```bash
sudo pacman -S --noconfirm --overwrite \* base-devel glibc linux-api-headers systemd mesa hidapi libevdev \
  libglvnd qt5-base qt5-multimedia qt5-svg sdl2 opus ffmpeg openssl gcc-libs fftw libva-mesa-driver
```

Now you have the option to either install chiaki from the official AUR or you can use a custom
PKGBUILD I created to build and install chiaki4deck instead.

### Build chiaki4deck from my custom PKGBUILD
```bash
mkdir /tmp/chiaki4deck
cd /tmp/chiaki4deck
curl -O 'https://raw.githubusercontent.com/tvidal-net/chiaki4deck-build/main/PKGBUILD'
makepkg -si --noconfirm
```

The final executable should be in `/usr/bin/chiaki` and
you should see chiaki on the start menu, to use it from the gamescope (steamdeck's non-desktop mode interface)
you just need to create a non-steam application running this executable.

Of course, you will lose any change made outside of your home directory whenever there is a steamos update
and may need to repeat the steps described above after the update.

And of course, don't forget to download great chiaki images from [steamgribdb](https://www.steamgriddb.com/game/5319543).
