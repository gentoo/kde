# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI="2"

KDE_LINGUAS="de es fr ja lt nl pt_BR ro ru"
inherit kde4-base

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://kdesvn.alwins-world.de/"
SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug +handbook"

DEPEND="
	>=dev-db/sqlite-3
	>=dev-util/subversion-1.4
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	!<kde-base/kdesdk-kioslaves-4.3.5[-kdeprefix]
	!>=kde-base/kdesdk-kioslaves-4.3.5[-kdeprefix,subversion]
"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT

	kde4-base_src_configure
}
