# based on https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=chiaki-git
pkgname=chiaki4deck-git
_gitname=chiaki4deck
pkgver=1.3.0
pkgrel=1
pkgdesc="Unofficial PlayStation 4 remote play client"
arch=(x86_64)
url="https://github.com/streetpea/chiaki4deck"
license=('AGPL3')
depends=('qt5-base' 'qt5-multimedia' 'qt5-svg' 'sdl2' 'opus' 'ffmpeg' 'openssl' 'gcc-libs' 'fftw')
makedepends=('git' 'cmake' 'python-protobuf' 'libva' 'python-setuptools')
optdepends=(
            'intel-media-driver: vaapi backend for Intel GPUs [>= Broadwell]'
            'libva-intel-driver: vaapi backend for Intel GPUs [<= Haswell]'
            'libva-vdpau-driver: vaapi backend for Nvidia and AMD GPUs'
            'libva-mesa-driver: alternative vaapi backend for AMD GPUs'
           )
provides=('chiaki')
conflicts=('chiaki')
source=(git+"${url}")
md5sums=("SKIP")

pkgver() {
  cd ${_gitname}
  git describe --long --tags | sed 's:^v::;s:\([^-]*-g\):r\1:;s:-:.:g'
}

prepare() {
  cd ${_gitname}
  mkdir build
  git submodule update --init
}

build() {
  cd ${_gitname}/build
  cmake .. -DCMAKE_INSTALL_PREFIX="/usr" -DCMAKE_BUILD_TYPE="Release"
  make -j
}

package() {
  cd ${_gitname}/build
  make -j DESTDIR="${pkgdir}" install
  install -dm755 "${pkgdir}/usr/share/licenses/${pkgname}/"
  for lic in ../LICENSES/*; do
    install -m644 ${lic} "${pkgdir}/usr/share/licenses/${pkgname}/${lic##*/}"
  done
}
