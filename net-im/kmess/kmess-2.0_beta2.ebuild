# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
KDE_LINGUAS="ar ca da de el es et fi fr hu it ko nb nl pt_BR sk sl sv th tr zh_CN zh_TW"
inherit kde4-base versionator

MY_P="${P/_/}"
DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux"
HOMEPAGE="http://www.kmess.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

COMMONDEPEND="
	app-crypt/qca:2
	app-crypt/qca-ossl
	dev-libs/libxml2
	dev-libs/libxslt
	x11-libs/libXScrnSaver
"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMONDEPEND}
	!kdeprefix? ( !net-im/kmess:0 )
"

src_prepare() {
	sed -i -e '/MACRO_LOG_FEATURE( QCA2_OSSL_PLUGIN_FOUND.*$/,/^.*t=3100" )/d' \
		CMakeLists.txt || die "failed to patch CMakeLists.txt"

	kde4-base_src_prepare
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "KMess can use the following optional packages:"
	elog "- net-www/netscape-flash		provides support for winks"
	echo
}
