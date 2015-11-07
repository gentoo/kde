# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KMNAME="oxygen-icons5"
KDE_AUTODEPS="false"
inherit kde5

DESCRIPTION="Oxygen SVG icon theme"
HOMEPAGE="https://kde.org/"

LICENSE="LGPL-3"
KEYWORDS=""
IUSE=""

DEPEND="$(add_frameworks_dep extra-cmake-modules)"
RDEPEND="!kde-apps/oxygen-icons:4"
