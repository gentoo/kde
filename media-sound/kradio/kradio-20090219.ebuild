# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="de es pl pt ru"
inherit kde4-base

MY_P="${PN}4-snapshot-${PV:0:4}-${PV:4:2}-${PV:6:2}-r630"
DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="alsa encode lirc +mp3 +vorbis v4l2"
SLOT="4"

DEPEND="
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	lirc? ( app-misc/lirc )
	mp3? ( media-sound/lame )
	vorbis? (
		media-libs/libvorbis
		media-libs/libogg
	)
"
RDEPEND="${DEPEND}"

# and i thoguht i saw everything :]
S="${WORKDIR}/home/urmel/kradio-svn/snapshots/${MY_P}"

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with alsa ALSA)
		$(cmake-utils_use_with mp3 LAME)
		$(cmake-utils_use_with vorbis OGG_VORBIS)
		$(cmake-utils_use_with lirc LIRC)
		$(cmake-utils_use_with v4l2 V4L2)"

	kde4-base_src_configure
}
