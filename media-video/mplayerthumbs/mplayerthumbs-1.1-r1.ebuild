# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A Thumbnail Generator for Video Files on Konqueror."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=41180"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/41180-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	|| (
		>=kde-base/dolphin-${KDE_MINIMAL}[kdeprefix=]
		>=kde-base/konqueror-${KDE_MINIMAL}[kdeprefix=]
	)
	|| (
		media-video/mplayer
		media-video/mplayer-bin
	)
"
