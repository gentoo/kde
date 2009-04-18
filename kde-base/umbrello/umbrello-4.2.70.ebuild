# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesdk"

inherit kde4-meta

DESCRIPTION="KDE UML Modeller"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND="
	dev-libs/boost
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}"
