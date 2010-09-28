# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblastfm/liblastfm-0.3.3.ebuild,v 1.1 2010/09/27 10:12:52 jmbsvicetto Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="http://github.com/mxcl/liblastfm/"
SRC_URI="http://github.com/mxcl/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE=""

S="${WORKDIR}/mxcl-liblastfm-1c739eb"

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

	# >=1.9 ruby compatibility
	case `ruby -e 'puts RUBY_VERSION'` in
		1.8.*) ;;
		*) sed -e "s/require 'ftools'//g" -i admin/* || die ;;
	esac

	epatch "${FILESDIR}/${P}-ruby-1.9-fix.patch" || die "Failed to apply patch to fix compilation with ruby-1.9"
}

src_configure() {
	./configure --prefix "${ROOT}usr" --no-strip --release || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}${ROOT}" install || die "emake install failed"

	dodoc README || die "dodoc failed"
}
