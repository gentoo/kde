# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="bg cs da de es fr hu is it ja nb nl pl pt_BR ru sk sv tr uk zh_CN zh_TW"

inherit cvs kde4-base

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
ECVS_SERVER="cvs.smb4k.berlios.de:/cvsroot/${PN}"
ECVS_MODULE="${PN}"
ECVS_LOCALNAME="${P}"

SLOT="live"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="bindist"

DEPEND=">=kde-base/konqueror-${KDE_MINIMAL}"
RDEPEND="${DEPEND}
	bindist? ( <net-fs/samba-3.2.0_pre2 )
	!bindist? ( net-fs/samba )
	net-fs/mount-cifs"

src_unpack() {
	cvs_src_unpack
}
