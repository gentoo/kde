# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.1"
KDE_LINGUAS="bg bs ca cs da de el es fr hu it ja lt nl pl pt pt_BR ru sk sl sr
sv tr uk zh_CN"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE="pic"

DEPEND="!kdeprefix? ( !kde-misc/krusader:0 )
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"
PREFIX="${KDEDIR}"

src_configure() {
	local mycmakeargs
	# for paranoid users
	use pic && mycmakeargs="${mycmakeargs} -DKDE4_ENABLE_FPIE=1"

	sed -i \
		-e "s:set(CMAKE_VERBOSE_MAKEFILE ON):#NADA:g" \
		CMakeLists.txt

	kde4-base_src_configure
}
