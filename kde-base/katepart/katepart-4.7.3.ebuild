# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kate"
KMMODULE="part"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE Editor KPart"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug"

add_blocker kdelibs 4.6.50

src_configure() {
	local mycmakeargs=(
		"-DKDE4_BUILD_TESTS=OFF"
	)

	kde4-meta_src_configure
}
