# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="KDE Educational: vocabulary trainer"
HOMEPAGE="http://www.kde.org/applications/education/parley
http://edu.kde.org/applications/school/parley"
KEYWORDS=""
IUSE="+plasma"

DEPEND="
	$(add_kdeapps_dep libkeduvocdocument)
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}
	!kde-base/parley:4
"
