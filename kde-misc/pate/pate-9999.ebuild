# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_DEPEND="2:2.4"
inherit git kde4-base python

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

src_unpack() {
	git_src_unpack
}
