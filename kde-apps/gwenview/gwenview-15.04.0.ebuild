# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE image viewer"
HOMEPAGE="
	http://www.kde.org/applications/graphics/gwenview/
	http://gwenview.sourceforge.net/
"
KEYWORDS=" ~amd64 ~x86"
IUSE="kipi raw semantic-desktop"

DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-gfx/exiv2:=
	media-libs/lcms:2
	media-libs/libpng:0=
	media-libs/phonon[qt5]
	virtual/jpeg:0
	x11-libs/libX11
	kipi? ( =kde-apps/libkipi-${PV} )
	raw? ( =kde-apps/libkdcraw-${PV} )
	semantic-desktop? ( $(add_plasma_dep baloo) )
"
RDEPEND="${DEPEND}
	!kde-base/gwenview:4
"

src_configure() {
	local mycmakeargs=(
			$(cmake-utils_use_find_package kipi KF5Kipi)
			$(cmake-utils_use_find_package raw KF5KDcraw)
			)
	# Workaround for bug #479510
	if [[ -e ${EPREFIX}/usr/include/${CHOST}/jconfig.h ]]; then
		mycmakeargs+=( -DJCONFIG_H="${EPREFIX}/usr/include/${CHOST}/jconfig.h" )
	fi

	if use semantic-desktop; then
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=Baloo)
	else
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=None)
	fi

	kde5_src_configure
}
