# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdegraphics-thumbnailers"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Thumbnail generators for PDF/PS and RAW files"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	$(add_frameworks_dep kio)
	dev-qt/qtcore:5
	dev-qt/qtgui:5
"

RDEPEND="${DEPEND}"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	S="${WORKDIR}/${KMNAME}-${PV}"
fi
