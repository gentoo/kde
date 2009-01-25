# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="bazaar cvs debug git htmlhandbook mercurial subversion"
LICENSE="GPL-2 LGPL-2"
SLOT="live"

DEPEND="
	subversion? ( >=dev-util/subversion-1.3 )
"
RDEPEND="${DEPEND}
	!kde-base/kdevplatform
	bazaar? ( dev-util/bzr )
	cvs? ( dev-util/cvs )
	git? ( dev-util/git )
	mercurial? ( dev-util/mercurial )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_bazaar=$(useq bazaar && echo ON || echo OFF)
		-DBUILD_cvs=$(useq cvs && echo ON || echo OFF)
		-DBUILD_git=$(useq git && echo ON || echo OFF)
		-DBUILD_mercurial=$(useq mercurial && echo ON || echo OFF)
		-DBUILD_subversion=$(useq subversion && echo ON || echo OFF)
		$(cmake-utils_use_with subversion SubversionLibrary)"

	kde4-base_src_configure
}
