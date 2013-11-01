# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit python-single-r1 kde4-base

DESCRIPTION="The classical Mah Jongg for four players"
HOMEPAGE="http://www.kde.org/applications/games/kajongg/"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-db/sqlite:3
	$(add_kdebase_dep libkdegames)
	$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}")
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep libkmahjongg)
	>=dev-python/twisted-core-8.2.0
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}

src_prepare() {
	python_fix_shebang src
	kde4-base_src_prepare
}
