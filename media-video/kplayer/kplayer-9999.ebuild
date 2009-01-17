# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="http://kde-apps.org/content/download.php?content=9833&id=1"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS=""
IUSE="debug"

DEPEND=">=media-video/mplayer-1.0_rc1"

CMAKE_IN_SOURCE_BUILD="1"