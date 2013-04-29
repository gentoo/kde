# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-python"
PYTHON_COMPAT=( python{2_7,3_1,3_2,3_3} )

if [[ $PV == *.9999* ]]; then
	EGIT_BRANCH="${PV/\.9999/}"
	KDEVPLATFORM_VERSION="${EGIT_BRANCH}"
fi

inherit kde4-base python-r1

MY_PN="${KMNAME}"
MY_PV="v${PV}"
MY_P="${MY_PN}-${MY_PV}"

if [[ $PV != *9999* ]]; then
	if [[ $PV == *[6-9][0-9]* ]]; then
		SRC_URI="mirror://kde/unstable/kdevelop/${MY_PN}/${PV}/src/${MY_P}.tar.bz2"
	else
		SRC_URI="mirror://kde/stable/kdevelop/${MY_PN}/${PV}/src/${MY_P}.tar.bz2"
	fi
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
else
	EGIT_REPO_URI="git://anongit.kde.org/kdev-python.git"
	KEYWORDS=""
fi

DESCRIPTION="Python plugin for KDevelop 4"
HOMEPAGE="http://www.kdevelop.org"

LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	${PYTHON_DEPS}
	>=dev-util/kdevelop-pg-qt-1.0.0
"
RDEPEND="
	${PYTHON_DEPS}
	dev-util/kdevelop
"

RESTRICT="test"

src_compile() {
	pushd "${WORKDIR}"/${P}_build
	emake parser
	popd

	kde4-base_src_compile
}
