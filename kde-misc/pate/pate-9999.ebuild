# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"
inherit python kde4-base

DESCRIPTION="Tasty Python plugins for Kate"
HOMEPAGE="http://github.com/pag/pate"
EGIT_REPO_URI="git://github.com/pag/${PN}.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	$(add_kdebase_dep kate)
	$(add_kdebase_dep pykde4 '' 4.9.2-r1)
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-pyqt.patch" )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-base_pkg_setup
}
