# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
inherit git python kde4-base

DESCRIPTION="Tasty Python plugins for Kate"
HOMEPAGE="http://github.com/pag/pate"
EGIT_REPO_URI="git://github.com/pag/${PN}.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	>=kde-base/kate-${KDE_MINIMAL}
	>=kde-base/pykde4-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
}

src_unpack() {
	git_src_unpack
}
