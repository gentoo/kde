# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/pim"
inherit kde4-base

DESCRIPTION="A Qt/KDE based mail client based on Akonadi."
HOMEPAGE="http://www.kde-apps.org/content/show.php/Mailody?content=47793"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug geolocation"

DEPEND="
	dev-libs/boost
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop]
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	geolocation? ( >=kde-base/marble-${KDE_MINIMAL} )
"
RDEPEND="${DEPEND}
	>=kde-base/nepomuk-${KDE_MINIMAL}
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with geolocation MarbleWidget)
	)

	kde4-base_src_configure
}
