# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-4.1.3.ebuild,v 1.2 2008/11/16 05:00:28 vapier Exp $

EAPI="2"

KMNAME=kdebase-runtime
KMMODULE=kioslave
inherit kde4-meta

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bzip2 debug htmlhandbook openexr samba"
RESTRICT="test"

# Note that if you upgrade strigi, you have to rebuild this package.
DEPEND=">=app-misc/strigi-0.5.7
	>=dev-libs/cyrus-sasl-2
	>=sys-apps/dbus-1.0.2
	=sys-apps/hal-0.5*
	x11-libs/libXcursor
	samba? ( >=net-fs/samba-3.0.1 )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )"
RDEPEND="${DEPEND}
	>=kde-base/kdesu-${PV}:${SLOT}
	>=kde-base/kdialog-${PV}:${SLOT}
	virtual/ssh"

KMEXTRA="kioexec
	kdeeject"

src_unpack() {
	if use htmlhandbook; then
		KMEXTRA="${KMEXTRA} doc/kioslave"
	fi
	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with samba Samba)
		$(cmake-utils_use_with openexr OpenEXR)"

	kde4-meta_src_configure
}
