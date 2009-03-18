# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="bg cs da de es fr hu is it ja nb nl pt pt_BR ru sk sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="1"
IUSE="debug bindist"

COMMON_DEPEND="
	>=kde-base/konqueror-${KDE_MINIMAL}[kdeprefix=]
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/cmake-2.6.1
"
RDEPEND="${COMMON_DEPEND}
	!kdeprefix? ( !net-misc/smb4k:0 )
	net-fs/mount-cifs
	!bindist? ( net-fs/samba )
	bindist? ( <net-fs/samba-3.2.0_pre2 )
"
