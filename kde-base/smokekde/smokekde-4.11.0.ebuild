# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - KDE bindings"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="attica debug kate okular"
HOMEPAGE="http://techbase.kde.org/Development/Languages/Smoke"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep smokeqt)
	attica? ( dev-libs/libattica )
	kate? ( $(add_kdebase_dep kate) )
	okular? ( $(add_kdebase_dep okular) )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with okular)
	)
	kde4-base_src_configure
}
