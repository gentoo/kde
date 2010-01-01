# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="http://kde-apps.org/content/download.php?content=9833&id=1"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="1"
IUSE="debug"

RDEPEND="
	!media-video/kplayer:0
	!media-video/kplayer:0.7
	>=media-video/mplayer-1.0_rc1
"

CMAKE_IN_SOURCE_BUILD="1"
