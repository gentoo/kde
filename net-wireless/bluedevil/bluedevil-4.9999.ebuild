# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="ar bs ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga gl
hu it ja kk km ko lt mai mr ms nb nds nl pa pl pt pt_BR ro ru sk sl sr
sr@ijekavian sr@ijekavianlatin sr@latin sv th tr ug uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/bluedevil"

LICENSE="GPL-2+"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/libbluedevil-2
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!app-mobilephone/obexd
	!app-mobilephone/obex-data-server
	!net-wireless/kbluetooth
"
