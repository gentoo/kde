# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Language learning application that helps improving pronunciation skills"
HOMEPAGE="http://edu.kde.org/applications/language/artikulate"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-qt/qtxmlpatterns:4
	>=media-libs/qt-gstreamer-1.2.0[qt4(+)]
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kqtquickcharts)
"
