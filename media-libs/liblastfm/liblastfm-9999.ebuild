# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib git-2

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
	>=x11-libs/qt-sql-4.5:4
"
DEPEND="${COMMON_DEPEND}
	dev-lang/ruby
	>=x11-libs/qt-test-4.5:4
"
RDEPEND="${COMMON_DEPEND}
	!<media-libs/lastfmlib-0.4.0
"

src_prepare() {
	# Fix multilib paths
	find . -name *.pro -exec sed -i -e "/target.path/s/lib/$(get_libdir)/g" {} + \
		|| die "failed to fix multilib paths"
}

src_configure() {
	./configure --prefix /usr --no-strip --release || die "configure failed"
}
