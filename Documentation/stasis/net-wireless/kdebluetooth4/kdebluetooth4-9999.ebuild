# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
#SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"
#ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/playground/network/kbluetooth4@{${PV//./}}"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/playground/network/kbluetooth4"

SLOT="kde-svn"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

# Localisation will be added once we have a release.

DEPEND=">=dev-libs/openobex-1.3
	app-mobilephone/obexftp
	app-mobilephone/obex-data-server"

RDEPEND="${DEPEND}
	|| ( ( kde-base/kdialog:${SLOT} kde-base/konqueror:${SLOT} )
		kde-base/kdelibs:${SLOT} )
	>=net-wireless/bluez-libs-3.11
	>=net-wireless/bluez-utils-3.11"
