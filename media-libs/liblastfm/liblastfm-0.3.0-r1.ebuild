# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblastfm/liblastfm-0.3.0.ebuild,v 1.8 2010/02/25 20:28:50 wired Exp $

EAPI="2"

USE_RUBY="ruby18"
inherit multilib ruby-ng

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="http://github.com/mxcl/liblastfm/"
SRC_URI="http://cdn.last.fm/src/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-ruby/rubygems
	>=media-libs/libsamplerate-0.1.4
	sci-libs/fftw:3.0
	>=x11-libs/qt-core-4.5:4
	>=x11-libs/qt-test-4.5:4
	>=x11-libs/qt-sql-4.5:4
	!<media-libs/lastfmlib-0.4.0"
RDEPEND="${DEPEND}"

all_ruby_prepare() {
	# Fix multilib paths
	find . -name *.pro -exec sed -i -e "/target.path/s/lib/$(get_libdir)/g" {} + \
		|| die "failed to fix multilib paths"
}

each_ruby_configure() {
	./configure --prefix "${ROOT}usr" --no-strip --release || die "configure failed"
}

each_ruby_compile() {
	emake || die "emake failed"
}

each_ruby_install() {
	emake DESTDIR="${D}${ROOT}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
