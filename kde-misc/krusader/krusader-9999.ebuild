# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="bg bs ca cs da de el es fr hu it ja ko lt nl pl pt pt_BR ru sk sl sr
sr@Latn sv tr uk zh_CN"
inherit kde4-base

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/${PN}_kde4"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug"

DEPEND="
	sys-devel/gettext
"
RDEPEND="
	!kdeprefix? ( !kde-misc/krusader:0 )
	!kde-misc/krusader:2
"

S="${WORKDIR}/${PN}_kde4"

src_prepare() {
	sed -i \
		-e "s:set(CMAKE_VERBOSE_MAKEFILE ON):#NADA:g" \
		CMakeLists.txt

	kde4-base_src_prepare
}
