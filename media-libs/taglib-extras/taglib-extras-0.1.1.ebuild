# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

# TODO add KMNAME=kdesupport handling in eclass
NEED_KDE="none"
inherit kde4-base

DESCRIPTION="Unofficial taglib plugins maintained by the Amarok team"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"
SRC_URI="http://www.jefferai.com/taglib-extras/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug kde"

RDEPEND="
	>=media-libs/taglib-1.5
	kde? ( >=kde-base/kdelibs-${KDE_MINIMAL} )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	# FIXME override kdeprefix flag for now (soon it will be dropped in eclass)
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=/usr
		$(cmake-utils_use_with kde KDE)"

	kde4-base_src_configure
}
