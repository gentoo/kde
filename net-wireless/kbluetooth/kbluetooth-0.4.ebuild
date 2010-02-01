# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KDE_LINGUAS="da de en_GB es et fr gl km lt nds pt pt_BR ro ru sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Bluetooth utils for KDE4"
HOMEPAGE="http://techbase.kde.org/Kbluetooth"
SRC_URI="http://kde-apps.org/CONTENT/content-files/112110-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug semantic-desktop"

COMMON_DEPEND=">=kde-base/solid-${KDE_MINIMAL}[bluetooth]
	>=kde-base/libkworkspace-${KDE_MINIMAL}
	>=kde-base/libknotificationitem-${KDE_MINIMAL}
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL} )"
RDEPEND="${COMMON_DEPEND}
	app-mobilephone/obex-data-server
	app-mobilephone/obexftp"
DEPEND="${COMMON_DEPEND}"

src_prepare() {
	kde4-base_src_prepare

	sed -e 's/${KDE4WORKSPACE_SOLIDCONTROL_LIBRARY}/solidcontrol/g' \
		-i src/CMakeLists.txt \
		-i src/device-manager/CMakeLists.txt \
		-i src/inputwizard/CMakeLists.txt \
		|| die "Failed to patch CMake files"
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)"
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
	ewarn "net-wireless/bluez can't work as normal user, so you need to setup"
	ewarn "your dbus privilege granting yourself, see bug:"
	ewarn "http://bugs.gentoo.org/279616"
}
