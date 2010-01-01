# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="bg cs da de es fr hu is it ja ko_KR nb nl pl pt_BR ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc"
inherit kde4-base cvs

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
ECVS_SERVER="cvs.smb4k.berlios.de:/cvsroot/${PN}"
ECVS_MODULE="${PN}"
ECVS_LOCALNAME="${P}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug handbook"

RDEPEND="
	|| ( >=net-fs/samba-client-3.4.2 net-fs/mount-cifs )
	>=kde-base/konqueror-${KDE_MINIMAL}
"
DEPEND="${RDEPEND}"
