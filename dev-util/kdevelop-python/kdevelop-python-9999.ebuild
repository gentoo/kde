# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"
KMNAME="kdevelop"
EGIT_REPONAME="kdev-python"
KDEVPLATFORM_VERSION="1.2.82"
inherit kde4-base python

DESCRIPTION="Python plugin for KDevelop 4"
SLOT="4"
KEYWORDS=""
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	>=dev-util/kdevelop-pg-qt-0.9.0
	dev-util/kdevelop
"
RDEPEND="${DEPEND}"

RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-base_pkg_setup
}

src_compile() {
	pushd "${WORKDIR}"/${P}_build > /dev/null
	emake parser
	popd > /dev/null

	kde4-base_src_compile
}
