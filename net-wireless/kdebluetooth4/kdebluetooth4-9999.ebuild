# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/playground/network/kbluetooth4"

SLOT="live"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-libs/openobex-1.3
	app-mobilephone/obexftp
	app-mobilephone/obex-data-server
"

RDEPEND="${DEPEND}
	>=kde-base/kdialog-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
	|| (
		( >=net-wireless/bluez-libs-3.11 >=net-wireless/bluez-utils-3.11 )
		net-wireless/bluez
	)
"
