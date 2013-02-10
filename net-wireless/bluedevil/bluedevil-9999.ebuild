# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="ar bs ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga hu
it ja kk ko lt mai ms nb nds nl pa pl pt pt_BR ro ru sk sl sr sr@ijekavian
sr@ijekavianlatin sr@latin sv th tr ug uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/bluedevil"

LICENSE="GPL-2+"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	net-libs/libbluedevil
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth
	app-mobilephone/obexd[-server]
	app-mobilephone/obex-data-server
"
