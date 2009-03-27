# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-4.2.1.ebuild,v 1.2 2009/03/08 13:34:18 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bzip2 debug openexr samba"
RESTRICT="test"

DEPEND="
	dev-libs/cyrus-sasl
	sys-apps/dbus
	sys-apps/hal
	x11-libs/libXcursor
	openexr? ( media-libs/openexr )
	samba? ( net-fs/samba )
"
RDEPEND="${DEPEND}
	>=kde-base/kdesu-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdialog-${PV}:${SLOT}[kdeprefix=]
	virtual/ssh
"

KMEXTRA="
	kioexec
	kdeeject
	doc/kioslave
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with samba Samba)
		$(cmake-utils_use_with openexr OpenEXR)"

	kde4-meta_src_configure
}

pkg_postinst() {
	echo
	elog "Note that if you upgrade strigi, you have to rebuild this package."
	echo

	kde4-meta_pkg_postinst
}
