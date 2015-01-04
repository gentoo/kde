# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_LINGUAS="cs de el es fr it ja lt pt_BR ro ru"
inherit flag-o-matic kde4-base

DESCRIPTION="KDESvn is a frontend to the subversion vcs"
HOMEPAGE="http://kdesvn.alwins-world.de/"
if [[ ${PV} != 9999* ]]; then
	SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"
fi

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/apr:1
	dev-libs/apr-util:1
	dev-qt/qtsql:4[sqlite]
	>=dev-vcs/subversion-1.7
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	!kde-base/kdesdk-kioslaves:4[subversion(+)]
"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT

	[[ ${PV} = 9999* ]] && local mycmakeargs=(-DDAILY_BUILD=ON)

	kde4-base_src_configure
}
