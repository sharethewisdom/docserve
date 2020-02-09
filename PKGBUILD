# Maintainer: Bart De Roy <de.roy.bart@gmail.com>
pkgname=docserve-git
pkgver=r2.c5e4e68
pkgrel=1
pkgdesc="Pacman hook for updating an index.html page with links to /usr/share/doc/**/index.html"
arch=('x86_64')
# url="https://github.com/sharethewisdom/${pkgname%-git}"
license=('GPL')
depends=('pacman')
# 'swaylock-blur-multimonitor-git' 
makedepends=('git')
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
source=("git+file:///home/bart/repos/PKGBUILDS/${pkgname%-git}")
md5sums=('SKIP')

pkgver() {
  cd "$srcdir/${pkgname%-git}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
  cd "$srcdir/${pkgname%-git}"
  make DESTDIR="$pkgdir" install
}
