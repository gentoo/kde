# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Extra Dolphin plugins"
KEYWORDS=""
IUSE="debug +bazaar +git +mercurial +subversion"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kompare)
	bazaar? ( dev-vcs/bzr )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	subversion? ( dev-vcs/subversion )
"

KMLOADLIBS="libkonq"

#
# See bug 351147 for why this is necessary
#
src_prepare() {
	echo 'macro_optional_add_subdirectory ( dolphin-plugins )' >> CMakeLists.txt || die
	echo > dolphin-plugins/CMakeLists.txt || die
	use bazaar && echo 'add_subdirectory ( bazaar )' >> dolphin-plugins/CMakeLists.txt
	use git && echo 'add_subdirectory ( git )' >> dolphin-plugins/CMakeLists.txt
	use mercurial && echo 'add_subdirectory ( hg )' >> dolphin-plugins/CMakeLists.txt
	use subversion && echo 'add_subdirectory ( svn )' >> dolphin-plugins/CMakeLists.txt

	kde4-meta_src_prepare
}

src_install() {
	{ use bazaar || use git || use mercurial || use subversion; } && kde4-meta_src_install
}
