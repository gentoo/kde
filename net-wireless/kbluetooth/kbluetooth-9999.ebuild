# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/network"
KMMODULE="kbluetooth"
KDE_MINIMAL="4.3"
inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
#SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug semantic-desktop"

DEPEND="
	>=app-mobilephone/obex-data-server-0.4.2
	>=app-mobilephone/obexftp-0.23_alpha[bluetooth]
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	>=kde-base/solid-${KDE_MINIMAL}[bluetooth]
"
RDEPEND="${DEPEND}
	>=kde-base/kdialog-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
	>=kde-base/nepomuk-${KDE_MINIMAL}
	!net-wireless/kdebluetooth4
"

src_prepare() {
	kde4-base_src_prepare

	sed -e 's/${KDE4WORKSPACE_SOLIDCONTROL_LIBRARY}/solidcontrol/g' \
		-i src/CMakeLists.txt \
		-i src/device-manager/CMakeLists.txt \
		-i src/inputwizard/CMakeLists.txt \
		|| die "Failed to patch CMake files"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)
	kde4-base_src_configure
}
