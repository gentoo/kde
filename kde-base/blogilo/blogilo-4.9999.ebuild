# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
EGIT_BRANCH="KDE/4.14"
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
HOMEPAGE="http://www.kde.org/applications/internet/blogilo"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep kdepimlibs)
	>=net-libs/libkgapi-2.2.0:4
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	composereditor-ng/
	pimcommon/
"
