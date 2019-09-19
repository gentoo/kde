# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Library to expose vcards to KPeople"
HOMEPAGE="https://cgit.kde.org/kpeoplevcard.git"

LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcontacts)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kpeople)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}"
