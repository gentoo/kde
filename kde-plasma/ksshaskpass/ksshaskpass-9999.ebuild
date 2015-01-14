# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE implementation of ssh-askpass with Kwallet integration"
HOMEPAGE="kde-apps.org/content/show.php?content=50971"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
"
RDEPEND="
	${DEPEND}
	!net-misc/ksshaskpass
"
