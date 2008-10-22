# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdegraphics
inherit kde4svn-meta

DESCRIPTION="KDE image viewer"
KEYWORDS=""
IUSE="debug htmlhandbook +semantic-desktop"
RESTRICT="test"

DEPEND="media-gfx/exiv2
	media-libs/jpeg
	semantic-desktop? ( kde-base/nepomuk:${SLOT} )"
RDEPEND="${DEPEND}"

PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)"

	kde4overlay-meta_src_compile
}
