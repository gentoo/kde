# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib git

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="http://github.com/mxcl/liblastfm/"
EGIT_REPO_URI="git://github.com/mxcl/liblastfm.git"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE=""

COMMON_DEPEND="
	>=media-libs/libsamplerate-0.1.4
	sci-libs/fftw:3.0
	>=x11-libs/qt-core-4.5:4
"
DEPEND="${COMMON_DEPEND}
	dev-lang/ruby
"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	# Fix multilib paths
	find . -name *.pro -exec sed -i -e "/target.path/s/lib/$(get_libdir)/g" {} + \
		|| die "failed to fix multilib paths"
}

src_configure() {
	./configure --prefix "${ROOT}usr" --no-strip --release || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}${ROOT}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
