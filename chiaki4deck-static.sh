#!/usr/bin/env sh
set -exo pipefail

if [ ! -d "chiaki4deck" ]
then
	git clone --single-branch --branch "main" --depth 1 \
		"https://github.com/streetpea/chiaki4deck.git"
fi
CHIAKI4DECK_DIR="$PWD/chiaki4deck"

cd "$CHIAKI4DECK_DIR"
git submodule update --init
rm -fv "third-party/nanopb/generator/proto/nanopb_pb2.py"

BUILD_DIR="/tmp/chiaki4deck-build"
[ -d "$BUILD_DIR" ] && rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake \
	-DBUILD_SHARED_LIBS=OFF \
	-DCHIAKI_ENABLE_CLI=OFF \
	-DCHIAKI_ENABLE_TESTS=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DCHIAKI_GUI_ENABLE_SDL_GAMECONTROLLER=ON \
	$CHIAKI4DECK_DIR

make -j && test/chiaki-unit

APP_DIR="$BUILD_DIR/Chiaki"
mkdir -p "$APP_DIR"
cp -v "$BUILD_DIR/gui/chiaki" \
	"/usr/lib/libfftw3.so.3" \
	"$APP_DIR"

tar acf "$BUILD_DIR/chiaki4deck-build.tar.bz2" -C "$BUILD_DIR" "Chiaki"
