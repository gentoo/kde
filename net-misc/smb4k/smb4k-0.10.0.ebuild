# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.1"
KDE_LINGUAS="bg cs da de es fr hu is it ja nb nl pt pt_BR ru sk sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="bindist"

DEPEND="|| ( >=kde-base/konqueror-4.1.1 >=kde-base/kdebase-4.1.1 )"
RDEPEND="${DEPEND}
	bindist? ( <net-fs/samba-3.2.0_pre2 )
	!bindist? ( net-fs/samba )
	>=dev-util/cmake-2.6.1
	!kdeprefix? ( !net-misc/smb4k:0 )
	net-fs/mount-cifs"

PREFIX="${KDEDIR}"
