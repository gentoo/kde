# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE UML Modeller"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
