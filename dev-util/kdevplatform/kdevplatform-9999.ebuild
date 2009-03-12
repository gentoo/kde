# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="1"
# Moved to playground for now
# bazaar mercurial
IUSE="cvs debug git subversion"

DEPEND="
	subversion? ( >=dev-util/subversion-1.3 )
"
# Moved to playground for now
# bazaar? ( dev-util/bzr )
# mercurial? ( dev-util/mercurial )
RDEPEND="${DEPEND}
	!kdeprefix? ( !dev-util/kdevelop:3 )
	cvs? ( dev-util/cvs )
	git? ( dev-util/git )
"

# Moved to playground for now
# -DBUILD_bazaar=$(useq bazaar && echo ON || echo OFF)
# -DBUILD_mercurial=$(useq mercurial && echo ON || echo OFF)
src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build cvs cvs)
		$(cmake-utils_use_build git git)
		$(cmake-utils_use_build subversion subversion)
		$(cmake-utils_use_with subversion SubversionLibrary)"

	kde4-base_src_configure
}
