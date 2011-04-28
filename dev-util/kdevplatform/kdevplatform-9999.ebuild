# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdevelop"
KDE_SCM="git"
EGIT_REPONAME="${PN}"
KDE_MINIMAL="4.6"
VIRTUALX_REQUIRED=test
KDE_LINGUAS="ca ca@valencia da de en_GB es et fi gl it nds nl pt pt_BR sl sv th uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"

KEYWORDS=""
# Moved to playground for now
# bazaar kompare mercurial
LICENSE="GPL-2 LGPL-2"
IUSE="cvs debug git reviewboard subversion"

# Moved to playground for now
# bazaar? ( dev-vcs/bzr )
# kompare? ( $(add_kdebase_dep kompare) )
# mercurial? ( dev-vcs/mercurial )
# block - some plugins moved to kdevplatform from kdevelop
DEPEND="
	dev-libs/boost
	reviewboard? ( dev-libs/qjson )
	subversion? ( >=dev-vcs/subversion-1.3 )
"
RDEPEND="${DEPEND}
	!<dev-util/kdevelop-${KDEVELOP_VERSION}:4
	!dev-util/kdevelop-git
	$(add_kdebase_dep konsole)
	cvs? ( dev-vcs/cvs )
	git? ( dev-vcs/git )
"

# Quite few fails and upstream is aware
RESTRICT="test"

src_prepare() {
	kde4-base_src_prepare

	# FindKDevPlatform.cmake is installed by kdelibs
	sed -i \
		-e '/cmakeFiles/s/^/#DONOTINSTALL/' \
		cmake/modules/CMakeLists.txt || die
}

# Moved to playground for now
# $(cmake-utils_use_build bazaar)
# $(cmake-utils_use_with kompare)
# $(cmake-utils_use_build mercurial)
src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build git)
		$(cmake-utils_use_with reviewboard QJSON)
		$(cmake-utils_use_build subversion)
		$(cmake-utils_use_with subversion SubversionLibrary)
	)

	kde4-base_src_configure
}
