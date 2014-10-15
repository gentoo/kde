# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-clang"
inherit kde5

DESCRIPTION="Clang plugin for KDevelop 5"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-util/kdevelop:5[-cxx]
	>=sys-devel/llvm-3.4[clang]
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "For first time after migration from kdevelop[cxx] to kdev-clang plugin,"
	ewarn "please run \"CLEAR_DUCHAIN_DIR=1 kdevelop -s\"."
}
