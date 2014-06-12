# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-python"
KDE_LINGUAS="bs ca ca@valencia da de es fi fr gl it kk nl pt pt_BR sk sl sv uk
zh_TW"
inherit kde4-base

MY_PN="${KMNAME}"
MY_P="${MY_PN}-${PV}"

if [[ $PV != *9999* ]]; then
	SRC_URI="mirror://kde/stable/kdevelop/${KDEVELOP_VERSION}/src/${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
else
	KEYWORDS=""
fi

DESCRIPTION="Python plugin for KDevelop 4"
IUSE="debug"

DEPEND=">=dev-util/kdevplatform-${PV}:4"
RDEPEND="
	${DEPEND}
	dev-util/kdevelop:4
"

RESTRICT="test"

src_compile() {
	pushd "${WORKDIR}"/${P}_build > /dev/null
	emake parser
	popd > /dev/null

	kde4-base_src_compile
}
