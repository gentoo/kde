# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Telepathy client for KDE"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
KEYWORDS="~amd64 ~x86"

LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 )"
SLOT="4"
IUSE=""

DEPEND=""
RDEPEND="
	>=net-im/telepathy-accounts-kcm-${PV}
	>=net-im/telepathy-accounts-kcm-plugins-${PV}
	>=net-im/telepathy-approver-${PV}
	>=net-im/telepathy-chat-handler-${PV}
	>=net-im/telepathy-contact-list-${PV}
	>=net-im/telepathy-presence-applet-${PV}"

pkg_postinst() {
	echo
	elog "You will need in KDE System Settings configure accounts"
	elog "and then open contact list and/or add plasma applet."
	echo
}
