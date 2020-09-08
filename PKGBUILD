# Maintainer: Bart De Roy <de.roy.bart@gmail.com>
pkgname=docserve-git
pkgver=r3.b2aa61d
pkgrel=1
pkgdesc="Pacman hook for updating an index.html page with links to /usr/share/**/*.html"
arch=('x86_64')
license=('GPL')
depends=('pacman')
makedepends=('git')
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
url="https://github.com/sharethewisdom/${pkgname%-git}"
source=("git+https://github.com/sharethewisdom/${pkgname%-git}.git")
md5sums=('SKIP')

pkgver() {
  cd "$srcdir/${pkgname%-git}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
  cd "$srcdir/${pkgname%-git}"
  make DESTDIR="$pkgdir" install
}

post_install(){
  /usr/share/libalpm/scripts/docserve_update.sh
cat <<'EOF'
Please configure nginx (see /usr/share/docserve/docserve.conf).
EOF
}
