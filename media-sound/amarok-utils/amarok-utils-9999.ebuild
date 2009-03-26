# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
KMMODULE="amarok"
NEED_KDE="none"
inherit kde4-base

DESCRIPTION="Variuos utility programs for Amarok."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="2"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.5
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-dbus-4.4:4
"
RDEPEND="${DEPEND}
	!<media-sound/amarok-2.1.0:${SLOT}
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=OFF
		-DWITH_UTILITIES=ON"

	kde4-base_src_configure
}
