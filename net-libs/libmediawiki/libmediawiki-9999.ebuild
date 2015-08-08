# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH=frameworks
inherit kde5

DESCRIPTION="KDE C++ interface for MediaWiki based web service as wikipedia.org"
HOMEPAGE="http://www.digikam.org/"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	MY_PV="${PV/_/-}"
	MY_P="digikam-${MY_PV}"
	SRC_URI="mirror://kde/stable/digikam/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P}/extra/${PN}
fi

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	dev-qt/qtnetwork:5
"
RDEPEND="${DEPEND}
	!net-libs/libmediawiki:4
"
