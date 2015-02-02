# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="KDE Telepathy client - merge this to pull in all net-im/ktp-*
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
	>=net-im/ktp-accounts-kcm-${PV}:4
	>=net-im/ktp-approver-${PV}:4
	>=net-im/ktp-auth-handler-${PV}:4
	>=net-im/ktp-call-ui-${PV}:4
	>=net-im/ktp-common-internals-${PV}:4
	>=net-im/ktp-contact-list-${PV}:4
	>=net-im/ktp-contact-runner-${PV}:4
	>=net-im/ktp-desktop-applets-${PV}:4
	>=net-im/ktp-filetransfer-handler-${PV}:4
	>=net-im/ktp-kded-module-${PV}:4
	>=net-im/ktp-send-file-${PV}:4
	>=net-im/ktp-text-ui-${PV}:4
	net-im/telepathy-connection-managers
"

pkg_postinst() {
	echo
	elog "You can configure the accounts in the KDE System Settings"
	elog "and then add the Instant Messaging plasma applet to access the contact list."
	echo
}
