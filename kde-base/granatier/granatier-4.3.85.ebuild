# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook +gluon"

DEPEND="
	gluon? ( media-libs/gluon )
	!gluon? ( >=x11-libs/qt-multimedia-${QT_MINIMAL}:4 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs+="
		$(cmake-utils_use_with gluon)
	"

	kde4-meta_src_configure
}
