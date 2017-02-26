# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="CD ripper and audio encoder frontend based on KDE Frameworks"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=107645"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_kdeapps_dep libkcddb)
	$(add_kdeapps_dep libkcompactdisc)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	media-libs/libdiscid
	media-libs/phonon[qt5]
	>=media-libs/taglib-1.5
"

RDEPEND="${DEPEND}
	$(add_kdeapps_dep audiocd-kio)
"

DOCS=( Changelog TODO )
