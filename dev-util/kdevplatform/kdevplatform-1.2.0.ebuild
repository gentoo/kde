# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevplatform/kdevplatform-1.2.0.ebuild,v 1.3 2011/02/27 14:40:39 dilfridge Exp $

EAPI=3

# Bug 276208
RESTRICT="test"

KDE_LINGUAS="ca ca@valencia da de en_GB es et fi gl it nds nl pt pt_BR sl sv th uk zh_CN zh_TW"

KMNAME="kdevelop"
KDE_MINIMAL="4.6"
inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
# Moved to playground for now
# bazaar kompare mercurial
LICENSE="GPL-2 LGPL-2"
IUSE="cvs debug git reviewboard subversion"

# Moved to playground for now
# bazaar? ( dev-vcs/bzr )
# kompare? ( >=kde-base/kompare-${KDE_MINIMAL} )
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

PATCHES="${FILESDIR}/${P}-gcc46.patch"

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
