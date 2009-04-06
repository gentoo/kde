# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/network"
KMMODULE="kbluetooth4"
KDE_MINIMAL="4.2"
inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	>=app-mobilephone/obex-data-server-0.4.2
	>=app-mobilephone/obexftp-0.23_alpha[bluetooth]
	>=kde-base/solid-${KDE_MINIMAL}[bluetooth]
"
RDEPEND="${DEPEND}
	>=kde-base/kdialog-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
"
