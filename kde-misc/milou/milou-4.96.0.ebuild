# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ $PV = *9999* ]]; then
	EGIT_BRANCH="frameworks"
	KEYWORDS=""
else
	SRC_URI="mirror://kde/unstable/plasma/${PV}/src/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi
inherit kde5

DESCRIPTION="Dedicated search application built on top of Baloo"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/milou"

LICENSE="GPL-2 LGPL-2.1"
IUSE=""

DEPEND="
	$(add_frameworks_dep krunner)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"
