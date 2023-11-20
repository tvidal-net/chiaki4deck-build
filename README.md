# Custom Chiaki4Deck Build

### Why ?

While lots of users can use the Chiaki4Deck official build from flatpak, for some reason
it does not work the same for everybody. I was one of these users which had constant crashes
and issues with it.

I tried building **Chiaki4Deck** myself and was surprised to realise it actually worked
without issues and decided to create a
[gist](https://gist.github.com/tvidal-net/dda93291eb5898d43ae268e063c928be)
to explain my solution and see if it would benefit other users, and was suprised to know
it actually did help other people.

I had a theory that the official **Chiaki4Deck** was being built using library dependencies that
were old or incompatible with SteamOS as the official repository uses `ubuntu:bionic` to build it
and SteamOS is based on **ArchLinux**.

### Where ?

Download and extract the [release](//github.com/tvidal-net/chiaki4deck-build/releases/tag/v1.0).

### How ?

I usually extract the files under the `$HOME/Games`:
```bash
mkdir -p ~/Games
tar xvf ~/Downloads/chiaki4deck-build.tar.bz2 -C ~/Games
```

Add a non-steam game with the following parameters:
* Target: `/usr/bin/env`
* Start In: `/home/deck/Games/Chiaki`
* Launch Options: `LD_LIBRARY_PATH=/home/deck/Games/Chiaki /home/deck/Games/Chiaki/chiaki`

For some reason I cannot understand, a single library `libfftw3.so.3` was not statically linked
and has to be present for this build to work. I used the `env` & `LD_LIBRARY_PATH` as a workaround
for this.

Please raise an issue if you have problems with this and I will try my best to help
you make this work on your system.