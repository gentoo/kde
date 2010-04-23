# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lokalize/lokalize-4.4.2.ebuild,v 1.1 2010/03/30 21:56:56 spatz Exp $

EAPI="3"

KMNAME="kdesdk"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="KDE4 translation tool"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

# Althrought they are purely runtime, its too useless without them
DEPEND="
	>=app-text/hunspell-1.2.8
	>=x11-libs/qt-sql-4.5.0:4[sqlite]
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesdk-strigi-analyzer)
	$(add_kdebase_dep krosspython)
	$(add_kdebase_dep pykde4)
"

src_prepare() {
	python_convert_shebangs -r 2 .
	kde4-meta_src_prepare
}

pkg_postinst() {
	echo
	elog "To be able to autofetch KDE translations in new project wizard, install subversion client:"
	elog "	emerge -vau subversion"
	echo
}
