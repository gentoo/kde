# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="Integrates Clang into KDevelop for C/C++/Objective-C language support."
HOMEPAGE="https://projects.kde.org/projects/playground/devtools/plugins/kdev-clang"
EGIT_REPO_URI="git://anongit.kde.org/kdev-clang"
SRC_URI=""

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sys-devel/llvm[clang]
	>=dev-util/kdevelop-4.6.90[-cxx]
	"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "For first time after migration from kdevelop[cxx] to kdev-clang plugin,"
	ewarn "please run \"CLEAR_DUCHAIN_DIR=1 kdevelop -s\"."
}
