# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_LINGUAS="cs de es fr it ja lt nl pl pt_BR ro ru"
KDE_LINGUAS_LIVE_OVERRIDE="true"
inherit flag-o-matic kde4-base

ESVN_REPO_URI="http://www.alwins-world.de/repos/kdesvn/trunk/"
ESVN_PROJECT="kdesvn"
DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://kdesvn.alwins-world.de/"
[[ ${PV} != 9999* ]] && SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=dev-db/sqlite-3
	>=dev-vcs/subversion-1.4
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	!<kde-base/kdesdk-kioslaves-4.3.5
	!>=kde-base/kdesdk-kioslaves-4.3.5[subversion]
"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT

	[[ ${PV} = 9999* ]] && mycmakeargs=(-DDAILY_BUILD=ON)

	kde4-base_src_configure
}
