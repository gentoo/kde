# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="
	app-mobilephone/obex-data-server
	app-mobilephone/obexftp
	dev-libs/openobex
"

RDEPEND="${DEPEND}
	|| ( ( >=kde-base/kdialog-4.1.2 >=kde-base/konqueror-4.1.2 )
		>=kde-base/kdelibs-4.1.2 )
	>=net-wireless/bluez-libs-3.25
	>=net-wireless/bluez-utils-3.25
"
