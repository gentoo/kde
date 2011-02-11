# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"

KMNAME="kate"
KMMODULE="part"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE Editor KPart"
KEYWORDS=""
IUSE="debug"

src_prepare() {
	mycmakeargs="-DKDE4_BUILD_TESTS=Off"
}
