# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
#SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/playground/network/kbluetooth4"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="live"
IUSE="debug"

DEPEND="
	>=app-mobilephone/obex-data-server-0.4.2
	>=app-mobilephone/obexftp_0.23_alpha[bluetooth]
	>=kde-base/solid-${KDE_MINIMAL}[bluetooth]
	>=kde-base/kdialog-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"
