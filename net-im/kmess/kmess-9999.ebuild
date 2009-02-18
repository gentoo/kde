# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
KDE_LINGUAS="ar ca da de el es et fi fr hu it ko nb nl pt_BR sk sl sv th tr zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux"
HOMEPAGE="http://www.kmess.org"
ESVN_REPO_URI="http://kmess.svn.sourceforge.net/svnroot/kmess/trunk/kmess"
ESVN_PROJECT="kmess"

LICENSE="GPL-2"

SLOT="live"
KEYWORDS=""
IUSE="debug"

COMMONDEPEND="
	app-crypt/qca:2
	dev-libs/libxml2
	dev-libs/libxslt
	x11-libs/libXScrnSaver
"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMONDEPEND}"

src_unpack() {
	kde4-base_src_unpack

	cp -R "${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}/.svn" "${S}" \
		|| ewarn "SVN revision information will not be available."
}

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
