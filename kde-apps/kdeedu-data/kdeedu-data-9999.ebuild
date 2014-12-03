# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_AUTODEPS="false"
inherit kde5

DESCRIPTION="Shared icons, artwork and data files for educational applications"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/extra-cmake-modules"
RDEPEND="
	!kde-base/libkdeedu:4
"
