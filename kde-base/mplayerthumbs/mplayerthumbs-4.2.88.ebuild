# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-1.2.ebuild,v 1.7 2009/04/26 15:02:28 scarabeus Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="A Thumbnail Generator for Video Files on KDE filemanagers."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=41180"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug mplayer"

RDEPEND="
	!media-video/mplayerthumbs
	|| (
		>=kde-base/dolphin-${PV}:${SLOT}[kdeprefix=]
		>=kde-base/konqueror-${PV}:${SLOT}[kdeprefix=]
	)
	mplayer? (
		|| (
			media-video/mplayer
			media-video/mplayer-bin
		)
	)
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DENABLE_PHONON_SUPPORT=ON"

	kde4-meta_src_configure
}
