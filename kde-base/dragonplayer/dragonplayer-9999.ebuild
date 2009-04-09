# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://dragonplayer.org/"

KEYWORDS=""
LICENSE="GPL-2"
IUSE="debug doc"

RDEPEND="
	>=media-libs/xine-lib-1.1.9
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
