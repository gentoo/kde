# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS=""
IUSE="debug htmlhandbook"
LICENSE="BSD LGPL-2"

DEPEND="
	kde-base/qimageblitz
"
RDEPEND="${DEPEND}"
