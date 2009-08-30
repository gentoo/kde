# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://dragonplayer.net/"

KEYWORDS=""
LICENSE="GPL-2"
IUSE="debug +handbook"

RDEPEND="
	>=media-libs/xine-lib-1.1.9[xcb]
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_prepare() {
	kde4-meta_src_prepare

	# Remove compile-time dep on LibKNotificationItem
	sed -i -e '/LibKNotificationItem-1/s/^/#DONOTNEED /' CMakeLists.txt
}
