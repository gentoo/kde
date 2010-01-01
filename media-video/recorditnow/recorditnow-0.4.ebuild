# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#KDE_LINGUAS="en cs de hu pt_BR"
# need patch to work select linguas

inherit kde4-base

DESCRIPTION="RecordItNow is a plugin based desktop recorder for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/RecordItNow?content=114610"
SRC_URI="http://kde-apps.org/CONTENT/content-files/114610-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug ffmpeg mplayer"

# Silly upstream has no clue about runtime and buildtime deps...
CDEPEND="
	x11-libs/libXfixes
	ffmpeg? ( media-video/ffmpeg )
	mplayer? ( media-video/mplayer )
"
DEPEND="${CDEPEND}
	x11-proto/fixesproto
"
RDEPEND="${CDEPEND}
	media-video/recordmydesktop
"

src_configure() {
	mycmakeargs+="
		$(cmake-utils_use_with mplayer Mencoder)
		$(cmake-utils_use_with ffmpeg)
	"
	kde4-base_src_configure
}
