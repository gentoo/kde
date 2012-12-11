# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
# need patch to work select linguas
#KDE_LINGUAS="cs de fr hu pt_BR tr"

inherit kde4-base

DESCRIPTION="RecordItNow is a plugin based desktop recorder for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/RecordItNow?content=114610"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug ffmpeg mplayer"

DEPEND="
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXfixes
	ffmpeg? ( virtual/ffmpeg )
	mplayer? ( media-video/mplayer )
"
RDEPEND="${DEPEND}
	media-video/recordmydesktop
"

PATCHES=( "${FILESDIR}/${P}-underlinking.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with mplayer Mencoder)
		$(cmake-utils_use_with ffmpeg)
	)
	kde4-base_src_configure
}
