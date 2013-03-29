# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdesdk"
fi
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit python-single-r1 ${eclass}

DESCRIPTION="KDE4 translation tool"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop"

DEPEND="
	>=app-text/hunspell-1.2.8
	>=dev-qt/qtsql-4.5.0:4[sqlite]
	semantic-desktop? ( >=dev-libs/soprano-2.9.0 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesdk-strigi-analyzer)
	$(add_kdebase_dep krosspython "${PYTHON_USEDEP}")
	$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}")
"

pkg_setup() {
	python-single-r1_pkg_setup
	${eclass}_pkg_setup
}

src_install() {
	${eclass}_src_install
	python_fix_shebang "${ED}/usr/share/apps/${PN}"
}

pkg_postinst() {
	${eclass}_pkg_postinst

	if ! has_version dev-vcs/subversion ; then
		elog "To be able to autofetch KDE translations in new project wizard, install dev-vcs/subversion."
	fi
}
