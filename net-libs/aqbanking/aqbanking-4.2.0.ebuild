# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt3

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=03&release=46&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="chipcard debug ofx qt3 qt4"

DEPEND=">=sys-libs/gwenhywfar-3.10.0.0
	>=app-misc/ktoblzcheck-1.14
	ofx? ( >=dev-libs/libofx-0.8.3 )
	chipcard? ( >=sys-libs/libchipcard-4.2.8 )
	qt3? ( =x11-libs/qt-3* )
	qt4? ( x11-libs/qt-core
	x11-libs/qt-qt3support
	x11-libs/qt-gui )"

MAKEOPTS="${MAKEOPTS} -j1"

RESTRICT="test"

pkg_setup() {
	if use qt3 && use qt4; then
	eerror "Both Qt3 and Qt4 are not supported"
	die "Disable either the \"qt3\" or the \"qt4\" USE flag"
	fi
}

src_configure() {
	local FRONTENDS="cbanking"
	(use qt3 || use qt4) && FRONTENDS="${FRONTENDS} qbanking"

	local BACKENDS="aqhbci"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"

	if use qt4; then
		QT4_LIBS="$(pkg-config QtCore QtGui Qt3Support --libs)"
		QT4_INC="$(pkg-config QtCore QtGui Qt3Support --cflags)"
	fi

	econf PATH="/usr/qt/3/bin:${PATH}" qt3_libs="${QT4_LIBS}" qt3_includes="${QT4_INC}" \
		$(use_enable debug) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" \
		--with-docpath="/usr/share/doc/${PF}/apidoc"|| die "configure failed"
	use qt4 && make qt4-port
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rm -rf "${D}/usr/share/doc"
	dodoc AUTHORS README doc/* || die "dodoc failed"
	find "${D}" -name '*.la' -delete
}
