# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Makes it possible to expose vcards to KPeople"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kpeople)
	$(add_kdeapps_dep kcontacts)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"
