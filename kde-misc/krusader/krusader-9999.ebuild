# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-2.0.0_beta1.ebuild,v 1.1 2008/10/15 21:14:00 jmbsvicetto Exp $

EAPI="2"

KDE_LINGUAS="bg bs ca cs da de el es fr hu it ja ko lt nl pl pt pt_BR ru sk sl sr
sr@Latn sv tr uk zh_CN"
inherit kde4-base

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/${PN}_kde4"
LICENSE="GPL-2"

SLOT="live"
KEYWORDS=""
IUSE="debug"

DEPEND="!kdeprefix? ( !kde-misc/krusader:0 )
	!kde-misc/krusader:2
	sys-devel/gettext"

S="${WORKDIR}/${PN}_kde4"

src_prepare() {
	sed -i \
		-e "s:set(CMAKE_VERBOSE_MAKEFILE ON):#NADA:g" \
		CMakeLists.txt

	kde4-base_src_prepare
}
