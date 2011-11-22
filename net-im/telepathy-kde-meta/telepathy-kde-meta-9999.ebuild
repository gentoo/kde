# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="KDE Telepathy client - merge this to pull in all net-im/telepathy*
kde packages"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 )"
SLOT="4"
IUSE=""

DEPEND=""
RDEPEND="
	>=net-im/telepathy-accounts-kcm-${PV}
	>=net-im/telepathy-approver-${PV}
	>=net-im/telepathy-auth-handler-${PV}
	>=net-im/telepathy-contact-applet-${PV}
	>=net-im/telepathy-contact-list-${PV}
	>=net-im/telepathy-filetransfer-handler-${PV}
	>=net-im/telepathy-kded-module-${PV}
	>=net-im/telepathy-presence-applet-${PV}
	>=net-im/telepathy-send-file-${PV}
	>=net-im/telepathy-text-ui-${PV}
	net-im/telepathy-connection-managers"

pkg_postinst() {
	echo
	elog "You will need in KDE System Settings configure accounts"
	elog "and then open contact list and/or add plasma applet."
	echo
}
