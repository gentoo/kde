# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - KDE bindings"
KEYWORDS=""
IUSE="akonadi attica debug kate nepomuk okular"
HOMEPAGE="http://techbase.kde.org/Development/Languages/Smoke"

DEPEND="
	$(add_kdebase_dep kdelibs 'nepomuk?')
	$(add_kdebase_dep smokeqt)
	akonadi? ( $(add_kdebase_dep kdepimlibs) )
	attica? ( dev-libs/libattica )
	kate? ( $(add_kdebase_dep kate) )
	okular? ( $(add_kdebase_dep okular) )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with nepomuk Nepomuk)
		$(cmake-utils_use_with nepomuk Soprano)
		$(cmake-utils_use_with okular)
	)
	kde4-base_src_configure
}
