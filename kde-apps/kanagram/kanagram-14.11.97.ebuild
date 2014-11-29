# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="Game based on anagrams of works"
HOMEPAGE="http://www.kde.org/applications/education/kanagram
http://edu.kde.org/kanagram"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_kdeapps_dep libkeduvocdocument)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5[qml]
	dev-qt/qtwidgets:5
	media-libs/phonon[qt5]
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kdeedu-data)
	dev-qt/qtquickcontrols:5
	!kde-base/kanagram:4
"
