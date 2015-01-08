# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for determining holidays and other special events for a geographical region"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="designer"

RDEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kitemviews)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	designer? ( dev-qt/designer:5 )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package designer Qt5Designer)
	)

	kde5_src_configure
}
