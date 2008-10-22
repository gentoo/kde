# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
SLOT="kde-svn"
NEED_KDE=":${SLOT}"
KMNAME="extragear/multimedia"

inherit kde4svn-meta
IUSE=""
PREFIX=${KDEDIR}

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="http://kde-apps.org/content/download.php?content=9833&id=1"

KEYWORDS=""
LICENSE="GPL-2"

RDEPEND=">=media-video/mplayer-1.0_rc1"

#src_unpack() {
#	kde4svn-meta_src_unpack
#	sed -i -e '/set(CMAKE_VERBOSE_MAKEFILE ON)/d' ${S}/CMakeLists.txt || die "Sed failed"
#}

#src_compile() {
#	cmake-utils_src_configurein
#	kde4overlay-base_src_make
#}
