# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.1"
KDE_LINGUAS="be br ca cs cy da de el en_GB es et eu fi fr ga gl he hu it ja nb
nds nl oc pa pl pt pt_BR ru sr sv tr zh_CN"
inherit kde4-base

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="http://kplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/mplayer-1.0_rc1"

src_prepare() {
	# doc not working
	sed -i \
		-e "s:set(CMAKE_VERBOSE_MAKEFILE ON):#nada:g" \
		-e "s:add_subdirectory(doc):#nada:g" \
		"${S}"/CMakeLists.txt
}

src_configure() {
	cmake-utils_src_configurein
}
