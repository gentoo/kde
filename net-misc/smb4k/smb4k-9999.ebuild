# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"

inherit cmake-utils cvs kde4svn

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
ECVS_SERVER="cvs.smb4k.berlios.de:/cvsroot/${PN}"
ECVS_MODULE="${PN}"
ECVS_LOCALNAME="${P}"

SLOT="kde-svn"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="bindist"

DEPEND="kde-base/konqueror:kde-svn"
RDEPEND="${DEPEND}
	bindist? ( <net-fs/samba-3.2.0_pre2 )
	!bindist? ( net-fs/samba )
	>=dev-util/cmake-2.6.1
	net-fs/mount-cifs"

src_unpack() {
	cvs_src_unpack
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}