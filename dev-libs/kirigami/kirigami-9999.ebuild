# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="forceoptional"
QT_MINIMAL="5.7.1"
inherit kde5

DESCRIPTION="Lightweight user interface framework for mobile and convergent applications"
HOMEPAGE="https://techbase.kde.org/Kirigami"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS=""
IUSE="examples plasma"

RDEPEND="
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtquickcontrols2)
	$(add_qt_dep qtsvg)
	plasma? ( $(add_frameworks_dep plasma) )
"
DEPEND="${RDEPEND}
	$(add_qt_dep linguist-tools)
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
		-DPLASMA_ENABLED=$(usex plasma)
	)

	kde5_src_configure
}
