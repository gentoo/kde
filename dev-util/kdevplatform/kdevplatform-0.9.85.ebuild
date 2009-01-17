# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

KDEVELOP_PV="3.9.85"
DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/unstable/kdevelop/${KDEVELOP_PV}/src/${P}.tar.bz2"

SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="bazaar cvs debug git htmlhandbook mercurial subversion teamwork"
LICENSE="GPL-2 LGPL-2"

DEPEND="subversion? ( >=dev-util/subversion-1.3 )
		teamwork? ( >=dev-libs/boost-1.34.0 >=dev-cpp/commoncpp2-1.5.9 )"

DEPEND="${DEPEND}
		bazaar? ( dev-util/bzr )
		cvs? ( dev-util/cvs )
		git? ( dev-util/git )
		mercurial? ( dev-util/mercurial )"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_bazaar=$(useq bazaar && echo ON || echo OFF)
		-DBUILD_cvs=$(useq cvs && echo ON || echo OFF)
		-DBUILD_git=$(useq git && echo ON || echo OFF)
		-DBUILD_mercurial=$(useq mercurial && echo ON || echo OFF)
		-DBUILD_subversion=$(useq subversion && echo ON || echo OFF)
		$(cmake-utils_use_with subversion SubversionLibrary)
		$(cmake-utils_use_with teamwork Boost)
		$(cmake-utils_use_with teamwork Commoncpp)"
	kde4-base_src_configure
}
