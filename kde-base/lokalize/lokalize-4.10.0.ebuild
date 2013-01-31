# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
KDE_SCM="svn"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="KDE4 translation tool"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop"

DEPEND="
	>=app-text/hunspell-1.2.8
	>=x11-libs/qt-sql-4.5.0:4[sqlite]
	semantic-desktop? ( >=dev-libs/soprano-2.9.0 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesdk-strigi-analyzer)
	$(add_kdebase_dep krosspython)
	$(add_kdebase_dep pykde4)
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-meta_pkg_setup
}

src_install() {
	kde4-meta_src_install
	python_convert_shebangs -q -r $(python_get_version) "${ED}/usr/share/apps/${PN}"
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	echo
	elog "To be able to autofetch KDE translations in new project wizard, install subversion client:"
	elog "	emerge -vau subversion"
	echo
}
