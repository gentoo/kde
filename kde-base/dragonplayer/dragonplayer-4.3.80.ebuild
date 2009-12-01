# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://www.dragonplayer.net/"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
IUSE="debug +handbook"

RDEPEND="
	>=media-libs/xine-lib-1.1.9[xcb]
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
