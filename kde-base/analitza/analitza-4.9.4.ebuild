# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="never"
inherit kde4-base

DESCRIPTION="KDE library for mathematical features"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug readline"

DEPEND="
	readline? ( sys-libs/readline )
"
RDEPEND="${DEPEND}"

add_blocker kalgebra 4.7.50

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with readline)
	)

	kde4-base_src_configure
}
