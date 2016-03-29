# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="A textedit with PIM-specific features"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kemoticons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-libs/grantlee:5
"
RDEPEND="${DEPEND}"
