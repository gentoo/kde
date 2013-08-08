# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="cs da de el en_GB es et fr hu it lt nb nds nl pa pl pt pt_BR ru sv
uk zh_CN zh_TW"
EGIT_REPONAME="wicd-kde"
MY_P=${P/-client/}
PYTHON_COMPAT=( python{2_6,2_7} )
inherit python-single-r1 kde4-base

DESCRIPTION="Wicd client built on the KDE Development Platform"
HOMEPAGE="http://kde-apps.org/content/show.php/Wicd+Client+KDE?content=132366"
[[ ${PV} == *9999 ]] || \
	SRC_URI="http://kde-apps.org/CONTENT/content-files/132366-${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	net-misc/wicd"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN/-client/}

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DPYTHONBIN=/usr/bin/python2
	)

	kde4-base_src_configure
}
