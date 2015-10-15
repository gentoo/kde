# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="A powerful flashcard and vocabulary learning program"
HOMEPAGE="https://www.kde.org/applications/education/kwordquiz https://edu.kde.org/kwordquiz"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep sonnet)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkeduvocdocument)
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	media-libs/phonon[qt5]
"
RDEPEND=${DEPEND}
