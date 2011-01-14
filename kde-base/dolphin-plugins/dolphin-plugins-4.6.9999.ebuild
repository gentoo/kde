# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Extra Dolphin plugins"
KEYWORDS=""
IUSE="debug +git +subversion"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kompare)
	git? ( dev-vcs/git )
	subversion? ( dev-vcs/subversion )
"

# SCM plugins moved from dolphin somewhere before 4.4.75
add_blocker dolphin '<4.4.75'

KMLOADLIBS="libkonq"

#
# See bug 351147 for why this is necessary
#
src_prepare() {
	echo 'macro_optional_add_subdirectory ( dolphin-plugins )' >> CMakeLists.txt || die
	echo > dolphin-plugins/CMakeLists.txt || die
	use git && echo 'add_subdirectory ( git )' >> dolphin-plugins/CMakeLists.txt
	use svn && echo 'add_subdirectory ( svn )' >> dolphin-plugins/CMakeLists.txt

	kde4-meta_src_prepare
}

src_install() {
	( ! use git && ! use svn ) || kde4-meta_src_install
}
