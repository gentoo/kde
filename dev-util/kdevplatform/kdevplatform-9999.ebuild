# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/sdk"
inherit kde4-base

if [[ ${PV} == *9999* ]]; then
	KDEVELOP_PV="9999"
else
	inherit versionator
	KDEVELOP_PV="$(($(get_major_version)+3)).$(get_after_major_version)"
fi
DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kdevelop.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://kde/unstable/kdevelop/${KDEVELOP_PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
# Moved to playground for now
# bazaar git
IUSE="cvs debug kompare mercurial subversion"

# Moved to playground for now
# bazaar? ( dev-util/bzr )
# git? ( dev-util/git )
# block - some plugins moved to kdevplatform from kdevelop
RDEPEND="
	!<dev-util/kdevelop-${KDEVELOP_PV}
	cvs? ( dev-util/cvs )
	kompare? ( >=kde-base/kompare-${KDE_MINIMAL} )
	mercurial? ( dev-util/mercurial )
	subversion? ( >=dev-util/subversion-1.3 )
"
DEPEND="${RDEPEND}
	dev-libs/boost
"

src_prepare() {
	kde4-base_src_prepare

	# FindKDevPlatform.cmake is installed by kdelibs
	sed -i \
		-e '/^add_subdirectory(modules)/s/^/#DONOTINSTALL/' \
		cmake/CMakeLists.txt || die
}

# Moved to playground for now
# $(cmake-utils_use_build bazaar)
# $(cmake-utils_use_build git)
src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build mercurial)
		$(cmake-utils_use_build subversion)
		$(cmake-utils_use_with kompare)
		$(cmake-utils_use_with subversion SubversionLibrary)
	)

	kde4-base_src_configure
}
