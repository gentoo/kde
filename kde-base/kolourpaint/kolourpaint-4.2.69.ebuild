# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
LICENSE="BSD LGPL-2"
IUSE="debug doc"

DEPEND="
	kde-base/qimageblitz
"
RDEPEND="${DEPEND}"
