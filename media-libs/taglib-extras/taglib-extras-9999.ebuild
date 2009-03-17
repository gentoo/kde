# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/multimedia"
NEED_KDE="none"
inherit kde4-base

DESCRIPTION="Unofficial taglib plugins maintained by the Amarok team"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug kde"

RDEPEND="
	>=media-libs/taglib-1.5
	kde? ( >=kde-base/kdelibs-${KDE_MINIMAL} )
"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kde KDE)"

	kde4-base_src_configure
}
