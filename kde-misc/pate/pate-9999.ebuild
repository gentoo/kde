# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/pag/${PN}.git"
PYTHON_DEPEND="2:2.4"

inherit kde4-base git python

DESCRIPTION="Tasty Python plugins for Kate"
HOMEPAGE="http://github.com/pag/pate"
SRC_URI=""

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""

IUSE=""

DEPEND="dev-python/sip
	>=kde-base/pykde4-${KDE_MINIMAL}
	dev-python/PyQt4"
RDEPEND="${DEPEND}
	>=kde-base/kate-${KDE_MINIMAL}"
