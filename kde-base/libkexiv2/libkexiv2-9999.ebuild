# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/libkexiv2"
inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/jpeg
	media-libs/lcms
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde4-meta_src_prepare

	# Remove compile-time dep on LibKNotificationItem
	sed -i -e '/LibKNotificationItem-1/s/^/#DONOTNEED /' CMakeLists.txt
}
