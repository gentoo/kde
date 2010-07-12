# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdesdk"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="KDE4 translation tool"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
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

pkg_setup() {
	kde4-meta_pkg_setup
	python_set_active_version 2
}

src_install() {
	kde4-meta_src_install
	python_convert_shebangs -q -r $(python_get_version) "${ED}${PREFIX}/share/apps/${PN}"
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	echo
	elog "To be able to autofetch KDE translations in new project wizard, install subversion client:"
	elog "	emerge -vau subversion"
	echo
}
