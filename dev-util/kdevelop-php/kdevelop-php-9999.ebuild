# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VIRTUALX_REQUIRED="test"
KDEBASE="kdevelop"
KMNAME="kdev-php"
EGIT_REPONAME="${KMNAME}"
inherit kde5

DESCRIPTION="PHP plugin for KDevelop 5"
LICENSE="GPL-2 LGPL-2"
IUSE="doc"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
	$(add_frameworks_dep kapidox)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-util/kdevelop-pg-qt:5
	>=dev-util/kdevplatform-${PV}:${SLOT}
"
RDEPEND="${DEPEND}
	dev-util/kdevelop:${SLOT}
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
