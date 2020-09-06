# Maintainer: Bart De Roy <de.roy.bart@gmail.com>
pkgname=docserve-git
pkgver=r3.b2aa61d
pkgrel=1
pkgdesc="Pacman hook for updating an index.html page with links to /usr/share/doc/**/index.html"
arch=('x86_64')
license=('GPL')
depends=('pacman')
makedepends=('git')
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
# url="https://github.com/sharethewisdom/${pkgname%-git}"
source=("git+file:///home/bart/write/devel/PKGBUILDS/${pkgname%-git}")
md5sums=('SKIP')

pkgver() {
  cd "$srcdir/${pkgname%-git}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
  cd "$srcdir/${pkgname%-git}"
  make DESTDIR="$pkgdir" install
}
