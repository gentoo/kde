# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
EGIT_BRANCH="KDE/4.14"
inherit kde4-meta

DESCRIPTION="KDE note taking utility"
HOMEPAGE="http://www.kde.org/applications/utilities/kjots/"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-libs/grantlee:0
	$(add_kdebase_dep kdepimlibs '-minimal(-)')
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi_next/
	noteshared/
"
