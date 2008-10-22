# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

NEED_KDE="svn"
SLOT="kde-svn"
inherit kde4svn

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

ESVN_REPO_URI="http://kmess.svn.sourceforge.net/svnroot/kmess/trunk/kmess"
DESCRIPTION="MSN Messenger clone for KDE"
HOMEPAGE="http://www.kmess.org"

LICENSE="LGPL-2"
KEYWORDS=""
IUSE="+xscreensaver"

DEPEND="app-crypt/qca-ossl
	dev-libs/libxml2
	dev-libs/libxslt
	sys-devel/gettext
	xscreensaver? ( x11-libs/libXScrnSaver )"

src_compile() {
	if ! use xscreensaver; then
		# Need to remove this otherwise linking fails:
		sed -i '/X11_Xscreensaver_FOUND/d' src/CMakeLists.txt || die "disabling xscreensaver failed."
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xscreensaver X11_Xscreensaver)"

	kde4overlay-base_src_compile
}
