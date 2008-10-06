# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="4.1"
IUSE=""


DEPEND="dev-libs/openobex
	app-mobilephone/obexftp
	app-mobilephone/obex-data-server"

RDEPEND="${DEPEND}
	|| ( ( kde-base/kdialog:${SLOT} kde-base/konqueror:${SLOT} )
		kde-base/kdelibs:${SLOT} )
	>=net-wireless/bluez-libs-3.25
	>=net-wireless/bluez-utils-3.25"
PREFIX="${KDEDIR}"
