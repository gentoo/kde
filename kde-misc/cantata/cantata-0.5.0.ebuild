# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Cantata is a client for the music player daemon (MPD)"
HOMEPAGE="http://kde-apps.org/content/show.php?content=147733"
SRC_URI="http://kde-apps.org/CONTENT/content-files/147733-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

DEPEND=""
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_want kde KDE_SUPPORT)
	)

	kde4-base_src_configure
}
