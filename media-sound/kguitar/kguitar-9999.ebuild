# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="de es it fr ru"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="Guitarist helper program focusing on tabulature editing and MIDI synthesizers support"
HOMEPAGE="http://kguitar.sf.net/"
ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/branches/kde4"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="midi"

DEPEND="midi? ( >=media-libs/tse3-0.3.0 )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=( $(cmake-utils_use midi WITH_TSE3) )
	kde4-base_src_configure
}
