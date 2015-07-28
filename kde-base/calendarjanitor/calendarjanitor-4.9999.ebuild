# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
EGIT_BRANCH="KDE/4.14"
KMMODULE="console/${PN}"
inherit kde4-meta

DESCRIPTION="A tool to scan calendar data for buggy instances"
HOMEPAGE="http://www.kde.org/"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep kdepimlibs '-minimal(-)')
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	calendarsupport/
"

KMLOADLIBS="kdepim-common-libs"
