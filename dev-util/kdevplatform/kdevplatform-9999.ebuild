# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdevelop"
KDE_SCM="git"
KDE_MINIMAL="4.7"
VIRTUALX_REQUIRED=test
KDE_LINGUAS="bs ca ca@valencia da de el en_GB es et fi fr it nb nds nl pl pt
pt_BR ru sl sv th uk zh_CN zh_TW"
EGIT_REPONAME="${PN}"

inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"
LICENSE="GPL-2 LGPL-2"
IUSE="cvs debug git reviewboard subversion"

if [[ $PV == *9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
fi

# Moved to playground for now
# bazaar? ( dev-vcs/bzr )
# kompare? ( $(add_kdebase_dep kompare) )
# mercurial? ( dev-vcs/mercurial )
DEPEND="
	dev-libs/boost
"
RDEPEND="${DEPEND}
	!<dev-util/kdevelop-${KDEVELOP_VERSION}:4
	$(add_kdebase_dep konsole)
	cvs? ( dev-vcs/cvs )
	git? ( dev-vcs/git )
	reviewboard? ( dev-libs/qjson )
	subversion? ( dev-vcs/subversion )
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
