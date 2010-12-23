# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdesdk"

inherit kde4-meta

DESCRIPTION="KDE UML Modeller"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-libs/boost
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}"
