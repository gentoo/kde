# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
# Moved to playground for now
# bazaar git
IUSE="cvs debug kompare mercurial subversion"

DEPEND="
	>=dev-libs/boost-1.35.0
	kompare? ( >=kde-base/kompare-4.3.1 )
	subversion? ( >=dev-util/subversion-1.3 )
"
# Moved to playground for now
# bazaar? ( dev-util/bzr )
# git? ( dev-util/git )
RDEPEND="${DEPEND}
	cvs? ( dev-util/cvs )
	mercurial? ( dev-util/mercurial )
"

# Moved to playground for now
# $(cmake-utils_use_build bazaar)
# $(cmake-utils_use_build git)
src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build mercurial)
		$(cmake-utils_use_build subversion)
		$(cmake-utils_use_with kompare)
		$(cmake-utils_use_with subversion SubversionLibrary)"

	kde4-base_src_configure
}
