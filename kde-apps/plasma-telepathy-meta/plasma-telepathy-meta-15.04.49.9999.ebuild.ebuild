# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="Plasma Telepathy client"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 )"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	$(add_kdeapps_dep ktp-accounts-kcm)
	$(add_kdeapps_dep ktp-approver)
	$(add_kdeapps_dep ktp-auth-handler)
	$(add_kdeapps_dep ktp-call-ui)
	$(add_kdeapps_dep ktp-common-internals)
	$(add_kdeapps_dep ktp-contact-list)
	$(add_kdeapps_dep ktp-contact-runner)
	$(add_kdeapps_dep ktp-desktop-applets)
	$(add_kdeapps_dep ktp-filetransfer-handler)
	$(add_kdeapps_dep ktp-kded-module)
	$(add_kdeapps_dep ktp-send-file)
	$(add_kdeapps_dep ktp-text-ui)
	!net-im/kde-telepathy-meta
"

pkg_postinst() {
	echo
	elog "You can configure the accounts in Plasma System Settings"
	elog "and then add the Instant Messaging plasma applet to access the contact list."
	echo
}
